/*

  #####  #####     ##    #    #  ######  #####    ####   ######           ####
	#    #    #   #  #   #    #  #       #    #  #       #               #    #
	#    #    #  #    #  #    #  #####   #    #   ####   #####           #
	#    #####   ######  #    #  #       #####        #  #        ###    #
	#    #   #   #    #   #  #   #       #   #   #    #  #        ###    #    #
	#    #    #  #    #    ##    ######  #    #   ####   ######   ###     ####

	Traversal of objects. Useful for storing objects and/or
	recursively coying them.
*/

/*
doc:<file name="traverse.c" header="eif_traverse.h" version="$Id$" summary="Traversal of objects">
*/

#include "eif_portable.h"
#include "rt_garcol.h"
#include "rt_malloc.h"
#include "rt_macros.h"
#include "eif_except.h"

#if !defined CUSTOM || defined NEED_STORE_H
#include "rt_store.h"
#endif
#if !defined CUSTOM || defined NEED_HASH_H
#include "rt_hashin.h"
#endif

#include "rt_hector.h"
#include "rt_traverse.h"
#include "rt_types.h"
#include "eif_memory.h"
#include "rt_gen_types.h"
#include "rt_gen_conf.h"
#include "rt_struct.h"
#include "x2c.h"		/* For LNGPAD macros... */
#include <string.h>				/* For memset() */
#include "rt_assert.h"

#define ACCOUNT_TYPE        0x01	/* accounted for type as seen */
#define ACCOUNT_ATTRIBUTES  0x04	/* accounted for types of attributes */

/*
 * Declarations
 */
/*#define DEBUG */		/**/

/*
doc:	<attribute name="map_stack" return_type="struct mstack" export="private">
doc:		<summary>Map table. It is used to record the EIF_OBJECT protections of all the objects created during the maping traversal. It is represented as a stack and not as an array to avoid fragmentation when resizing (since we do not know how many objects we will traverse)--RAM.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_eo_store_mutex' lock.</synchronization>
doc:	</attribute>
*/
rt_private struct mstack map_stack;

/*
doc:	<attribute name="obj_nb" return_type="uint32" export="shared">
doc:		<summary>Counter of marked objects. Only used with ISE_GC.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_eo_store_mutex' lock.</synchronization>
doc:	</attribute>
*/
rt_shared uint32 obj_nb;

#ifdef EIF_THREADS
/*
doc:	<attribute name="eif_eo_store_mutex" return_type="EIF_LW_MUTEX_TYPE" export="shared">
doc:		<summary>When using EO_MARK to mark object, the full marking and unmarking process should be protected using this mutex. Not doing so, you might end up marking objects marked by a different thread or unmarking them, at the end it is a mess.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_shared EIF_LW_MUTEX_TYPE *eif_eo_store_mutex = NULL;
#endif

#ifdef DEBUG
rt_shared uint32 nomark(char *);
rt_private uint32 chknomark(char *, struct htable *, long);
#endif

rt_private EIF_REFERENCE matching (void (*action_fnptr) (EIF_REFERENCE, EIF_REFERENCE), int result_type);
rt_private void match_object (EIF_REFERENCE object, void (*action_fnptr) (EIF_REFERENCE, EIF_REFERENCE));
rt_private void match_simple_stack (struct stack *stk, void (*action_fnptr) (EIF_REFERENCE, EIF_REFERENCE));
rt_private void match_stack (struct stack *stk, void (*action_fnptr) (EIF_REFERENCE, EIF_REFERENCE));

rt_private void internal_find_all_instances (EIF_REFERENCE enclosing, EIF_REFERENCE compare_to);
rt_private void internal_find_instance_of (EIF_REFERENCE enclosing, EIF_REFERENCE compare_to);
rt_private void internal_find_referers (EIF_REFERENCE enclosing, EIF_REFERENCE compare_to);

/*
doc:	<routine name="account_attributes" export="private">
doc:		<summary>Account for types of attributes of dynamic type `dtype'.</summary>
doc:		<param name="dtype" type="int16">Dynamic type from which we want to know the types of its attributes.</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_eo_store_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_private void account_attributes (int16 dtype)
{
	RT_GET_CONTEXT
	long num_attrib = System (dtype).cn_nbattr;
	long i, k;
	for (i=0; i<num_attrib; i++) {
		int16 *gtypes = System (dtype).cn_gtypes[i] + 1;
		for (k=0; gtypes[k] != TERMINATOR; k++) {
			int gtype = gtypes[k];
			if (gtype == TUPLE_TYPE) {
				k = k + TUPLE_OFFSET;
				gtype = gtypes[k];
			}
			if (gtype == FORMAL_TYPE) {
					/* Skip formal position, no special treatment to be done. */
				k = k + 1;
			} else {
				if (gtype >= 0) {
					gtype = RTUD (gtype);
				}
				if (gtype >= 0) {
					account[gtype] |= ACCOUNT_TYPE;
				}
			}
		}
	}
}

/*
doc:	<routine name="account_type" export="private">
doc:		<summary>Account for type of object found.</summary>
doc:		<param name="dftype" type="int16">Full dynamic type from which we want to know the types of its attributes.</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_eo_store_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_private void account_type (uint32 dftype, int p_accounting)
{
	RT_GET_CONTEXT
	int16  *l_cidarr, dtype, i;

	dtype = Deif_bid(dftype);

# ifdef RECOVERABLE_DEBUG
	if ((account[dtype] & ACCOUNT_TYPE) == 0) {
		printf ("Processing traversal of %s\n", eif_typename ((int16) dftype));
	}
# endif

	account[dtype] |= ACCOUNT_TYPE;	/* This type is present */

	/* Account for declared types of the attributes of the type. This
	 * is important because the declared type of an attribute may be
	 * different from the object which is attached to it (through
	 * conformance).
	 */
	if (p_accounting & TR_ACCOUNT_ATTR)
		if ((account[dtype] & ACCOUNT_ATTRIBUTES) == 0) {
			account[dtype] |= ACCOUNT_ATTRIBUTES;
			account_attributes (dtype);
		}

	if (dftype != (uint32) dtype) {
		/* Now insert generics if any */
		l_cidarr = eif_gen_cid ((int16) dftype);
		i = *(l_cidarr++); /* count */

		while (i--)
		{
			dtype = *(l_cidarr++);

			if (dtype == TUPLE_TYPE) {
				i = i - TUPLE_OFFSET;
				l_cidarr += TUPLE_OFFSET;
				dtype = *l_cidarr;
			}

				/* No need to handle special type since they should not appear in an object
				 * type.
				 */
			CHECK ("No special type",
				(dtype != LIKE_CURRENT_TYPE) && (dtype != LIKE_ARG_TYPE) &&
				(dtype != LIKE_FEATURE_TYPE) && (dtype != LIKE_PFEATURE_TYPE) &&
				(dtype != FORMAL_TYPE));

			if (dtype >= 0)
				account[dtype] |= ACCOUNT_TYPE;
		}
	}
}

/*
doc:	<routine name="traversal" export="shared">
doc:		<summary>First pass of the store mechanism consisting in marking objects with the EO_STORE flag.</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object from which we start the marking mechanism.</param>
doc:		<param name="p_accounting" type="int">Type of possible accounting (TR_PLAIN, TR_ACCOUNT, TR_MAP, TR_ACCOUNT_ATTR, INDEPEND_ACCOUNT or RECOVER_ACCOUNT).</param>
doc:		<exception>"No more memory" when it fails</exception>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_eo_store_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_shared void traversal(EIF_REFERENCE object, int p_accounting)
{
	/* First pass of the store mechanism consisting in marking objects. */

	EIF_GET_CONTEXT
	char *object_ref, *reference;
	EIF_INTEGER count, elem_size;
	union overhead *zone;		/* Object header */
	uint32 flags;				/* Object flags */
	char *new;					/* Mapped object */
	EIF_OBJECT mapped;				/* Mapped object protection */
	int mapped_object = 0;		/* True if maping occurred */
	int i;						/* To iterate over the references */

	zone = HEADER(object);
	flags = zone->ov_flags;

	if (flags & EO_C)				/* Stop on C objects */
		return;

	if (flags & EO_STORE)			/* Object is already marked? */
		return;						/* Then we already dealt with it */

	if (!(flags & EO_EXP)) {		/* Mark the object if not expanded */

		/* If a maping table is to be built, create a new object and insert it
		 * in the map table. The reference is protected by requesting insertion
		 * in the hector stack. There is no need to check for a null pointer
		 * upon return from spmalloc, emalloc or hrecord since those calls will
		 * raise an exception if there is not enough memory to perform the
		 * operation.
		 */

		if (p_accounting & TR_MAP) {
			RT_GC_PROTECT(object);		/* Protection against GC */
			new = eclone(object);
			mapped = hrecord(new);
			if (-1 == epush((struct stack *) &map_stack, (char *) mapped))
				eraise("map table recording", EN_MEM);
			zone = HEADER(object);			/* Object may have moved */
			flags = zone->ov_flags;			/* Flags may have changed */
			mapped_object = 1;				/* Maping occurred */
		}

		/* It is important to count the objects only once they have been
		 * recorded in the mapping stack (eventually), since the emergency
		 * release of the stack relies on an accurate object count.
		 */

		flags |= EO_STORE;			/* Object marked as traversed */
		obj_nb++; 					/* Count the number of objects traversed */
	}

#if !defined CUSTOM || defined NEED_STORE_H
	if (p_accounting & TR_ACCOUNT) {	/* Possible accounting */
		account_type (flags & EO_TYPE, p_accounting);
# ifdef RECOVERABLE_DEBUG
		if (flags & EO_EXP)
			printf ("      expanded %s [%p]\n", eif_typename ((int16) (flags & EO_TYPE)), object);
		else
			printf ("%2ld: %s [%p]\n", obj_nb, eif_typename ((int16) (flags & EO_TYPE)), object);
# endif

	}
#endif

	zone->ov_flags = flags;			/* Mark the object */

	/* Evaluation of the number of references of the object. It is really
	 * important that we traverse the objects in the same way a deep clone
	 * would, or the maping operation would not match the object graph
	 * topology--RAM.
	 */

	if (flags & EO_SPEC) {			/* Special object */
		if (!(flags & EO_REF)) {	/* Object does not have any reference */
			if (mapped_object)
				RT_GC_WEAN(object);
			return;
		}

		/* Evaluation of the number of items in the special object */
		object_ref = RT_SPECIAL_INFO_WITH_ZONE(object, zone);
		count = RT_SPECIAL_COUNT_WITH_INFO(object_ref);

		if (flags & EO_TUPLE) {
			EIF_TYPED_ELEMENT *l_item = (EIF_TYPED_ELEMENT *) object;
				/* Don't forget that first element of TUPLE is just a placeholder
				 * to avoid offset computation from Eiffel code */
			l_item++;
			count--;
			for (; count > 0; count--, l_item++) {
				if
					((eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE) &&
				 	(eif_reference_tuple_item(l_item)))
				{
					traversal(eif_reference_tuple_item(l_item), p_accounting);	
				}
			}
		} else if (!(flags & EO_COMP))
			/* Special object filled with references */
			for (i = 0; i < count; i++) {
				reference = *((char **) object + i);
				if (0 != reference)		/* Non void reference */
					traversal(reference, p_accounting);
			}
		else {
			/* Special object filled with expanded objects which are
			 * necessary not special objects.
			 */
			int offset = OVERHEAD;
			elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(object_ref);
			for (i = 0; i < count; i++, offset += elem_size)
				traversal(object + offset, p_accounting);
		}
	} else {
		/* Normal object */
		count = Deif_bid(flags);
		count = References(count);

		/* Traversal of references of `object' */
		for (i = 0; i < count; i++) {
			reference = *((char **) object + i);
			if ((char *) 0 != reference)
				traversal(reference, p_accounting);
		}
	}

	if (mapped_object)
		RT_GC_WEAN(object);
}

/*
 * Indirection table handling.
 */

/*
doc:	<routine name="map_start" export="shared">
doc:		<summary>Restart the maping table at the beginning. Note that we are using the extra st_bot field which is added after all the fields from the stack structure.</summary>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_eo_store_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_shared void map_start(void)
{
	map_stack.st_bot = map_stack.st_hd->sk_arena;	/* First item */
	map_stack.st_cur = map_stack.st_hd;
	map_stack.st_end = map_stack.st_cur->sk_end;
}

/*
doc:	<routine name="map_next" return_type="EIF_OBJECT" export="shared">
doc:		<summary>Return next object in the map table, via its indirection pointer. Note that the stack structure is physically destroyed in the process, being mangled from the bottom.</summary>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_eo_store_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_shared EIF_OBJECT map_next(void)
{
	EIF_OBJECT *item;		/* Item we shall return */
	struct stchunk *cur;	/* New current chunk */

	REQUIRE ("Not at the end of the stack", map_stack.st_bot != map_stack.st_top);
	
	item = (EIF_OBJECT *) map_stack.st_bot++;		/* Make a guess */
	if (item >= (EIF_OBJECT *) map_stack.st_end) {	/* Bad guess (beyond chunk) */
		cur = map_stack.st_cur->sk_next;		/* Advance one chunk */

		CHECK ("We should have a chunk", cur);

		map_stack.st_end = cur->sk_end;			/* Precompute end of chunk */
		map_stack.st_bot = cur->sk_arena;		/* This is the new bottom */
		item = (EIF_OBJECT *) map_stack.st_bot++;	/* Next item in stack */
		eif_rt_xfree((char *) (map_stack.st_cur));				/* Free previous chunk */
		map_stack.st_cur = cur;					/* It's the new first chunk */
		map_stack.st_hd = cur;					/* In case of emergency */
	}

	ENSURE ("Object found before end of stack", item != (EIF_OBJECT *) map_stack.st_top);
	
	return *item;
}

/*
doc:	<routine name="map_reset" export="shared">
doc:		<summary>At the end of a cloning operation, the stack is reset (i.e. emptied) and a consistency check is made to ensure it is really empty.</summary>
doc:		<param name="emergency" type="int">Need to reset due to emergency (exception)?</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_eo_store_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_shared void map_reset(int emergency)
			  		/* Need to reset due to emergency (exception) */
{
	EIF_GET_CONTEXT
	struct stchunk *next;	/* Next chunk in stack list */
	struct stchunk *cur;	/* Current chunk in stack list */

	REQUIRE ("", emergency || map_stack.st_bot == map_stack.st_top);
	
	/* If we get here because of an emergency, we free all the chunks held
	 * in the stack until the end. Otherwise, we only need to free the current
	 * (and last) chunk.
	 */

	if (emergency) {
		for (next = map_stack.st_hd; next != 0; /*empty */) {
			cur = next;						/* Current chunk to be freed */
			next = next->sk_next;			/* Compute next chunk... */
			eif_rt_xfree((char *) cur);			/* ...before freeing it */
		}
	} else
		eif_rt_xfree((char *) (map_stack.st_cur));	/* Free last chunk in stack */

	memset (&map_stack, 0, sizeof(map_stack));	/* Reset an empty stack */
	/* Release all the hector pointers asked for during the map table
	 * construction (obj_nb exactly, even if we were interrupted by an
	 * exception in the middle of the traversal...
	 */

#ifdef ISE_GC
	epop(&hec_stack, obj_nb);		/* Remove stacked EIF_OBJECT pointers */
#endif
}

/*
doc:	<attribute name="referers_target" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Object for which we track all the objects that refers to it in `find_referers'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</attribute>
*/
rt_private EIF_REFERENCE referers_target = NULL;

/*
doc:	<attribute name="instance_type" return_type="EIF_INTEGER" export="private">
doc:		<summary>Dynamic type used to track all objects of this particular dynamic type in `find_instance_of'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</attribute>
*/
rt_private EIF_INTEGER instance_type = 0;

/*
doc:	<routine name="find_referers" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>Find all objects that refers to `target' and return a SPECIAL object.</summary>
doc:		<param name="target" type="EIF_REFERENCE">Object from which we want to find all objects that refer to it.</param>
doc:		<param name="result_type" type="EIF_INTEGER">Full dynamic type of SPECIAL [ANY].</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE find_referers (EIF_REFERENCE target, EIF_INTEGER result_type)
{
	RT_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	GC_THREAD_PROTECT(eif_synchronize_gc (rt_globals));
	referers_target = target;
	result = matching (internal_find_referers, result_type);
	GC_THREAD_PROTECT(eif_unsynchronize_gc (rt_globals));
	return result;
}

/*
doc:	<routine name="find_instance_of" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>Find all object that have `type' as dynamic type and return a SPECIAL object containing them all.</summary>
doc:		<param name="type" type="EIF_INTEGER">Dynamic type of objects we are looking for.</param>
doc:		<param name="result_type" type="EIF_INTEGER">Full dynamic type of SPECIAL[ANY].</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE find_instance_of (EIF_INTEGER type, EIF_INTEGER result_type)
{
	RT_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	GC_THREAD_PROTECT(eif_synchronize_gc (rt_globals));
	instance_type = type;
	result = matching (internal_find_instance_of, result_type);
	GC_THREAD_PROTECT(eif_unsynchronize_gc (rt_globals));
	return result;
}

/*
doc:	<routine name="find_all_instances" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>Find all objects in system and return a SPECIAL object containing them all.</summary>
doc:		<param name="result_type" type="EIF_INTEGER">Full dynamic type of SPECIAL[ANY].</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Through `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/

rt_public EIF_REFERENCE find_all_instances (EIF_INTEGER result_type)
{
	RT_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	GC_THREAD_PROTECT(eif_synchronize_gc (rt_globals));
	result = matching (internal_find_all_instances, result_type);
	GC_THREAD_PROTECT(eif_unsynchronize_gc (rt_globals));
	return result;
}


/*
doc:	<attribute name="found_collection" return_type="struct obj_array *" export="private">
doc:		<summary>Collects all matching objects found in `find_instance_of' or `find_referers'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</attribute>
*/
rt_private struct obj_array *found_collection = NULL;

/*
doc:	<attribute name="marked_collection" return_type="struct obj_array *" export="private">
doc:		<summary>Keeps all objects marked during search in `find_instance_of' or `find_referers'.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</attribute>
*/
rt_private struct obj_array *marked_collection = NULL;

/*
doc:	<routine name="obj_array_extend" export="private">
doc:		<summary>Add `obj' to `a_collection'.</summary>
doc:		<param name="obj" type="EIF_REFERENCE">Object to add in `a_collection'.</param>
doc:		<param name="a_collection" type="struct obj_array *">Collection in which `obj' is added.</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_private void obj_array_extend (EIF_REFERENCE obj, struct obj_array *a_collection)
{
	a_collection->index = a_collection->index + 1;

	if (a_collection->index >= a_collection->capacity) {
		a_collection->capacity = a_collection->capacity * 2;
		a_collection->area = realloc (a_collection->area, sizeof (EIF_REFERENCE) * (a_collection->capacity));
	}
	a_collection->area [a_collection->index] = obj;
	a_collection->count = a_collection->count + 1;
}

/*
doc:	<routine name="internal_find_instance_of" export="private">
doc:		<summary>Check if dynamic type of `compare_to' and `enclosing' matches `instance_type'. If so, add it to `found_collection'.</summary>
doc:		<param name="enclosing" type="EIF_REFERENCE">Object we possibly want to add to `found_collection'.</param>
doc:		<param name="compare_to" type="EIF_REFERENCE">Only for signature purposes. We only do something if `enclosing' references the same object as `compare_to'.</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_private void internal_find_instance_of (EIF_REFERENCE enclosing, EIF_REFERENCE compare_to)
{
	if
		((enclosing == compare_to) &&
		((EIF_INTEGER) ((HEADER(enclosing)->ov_flags) & EO_TYPE) == instance_type ? 1 : 0) &&
		(!((HEADER(enclosing)->ov_flags) & EO_STORE)))
	{
		obj_array_extend (enclosing, found_collection);
	}
}

/*
doc:	<routine name="internal_find_all_instances" export="private">
doc:		<summary>Add `enclosing' to `found_collection' if not yet processed, as we try to find all objects in universe.</summary>
doc:		<param name="enclosing" type="EIF_REFERENCE">Object we possibly want to add to `found_collection'.</param>
doc:		<param name="compare_to" type="EIF_REFERENCE">Only for signature purposes. We only do something if `enclosing' references the same object as `compare_to'.</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_private void internal_find_all_instances (EIF_REFERENCE enclosing, EIF_REFERENCE compare_to)
{
	if ((enclosing == compare_to) && (!((HEADER(enclosing)->ov_flags) & EO_STORE))) {
		obj_array_extend (enclosing, found_collection);
	}
}

/*
doc:	<routine name="internal_find_referers" export="private">
doc:		<summary>Check if `compare_to' refers to `referers_target' and that `enclosing' is not equal to `compare_to'. If it matches, then we add `enclosing' to `found_collection'.</summary>
doc:		<param name="enclosing" type="EIF_REFERENCE">Object we possibly want to add to `found_collection'.</param>
doc:		<param name="compare_to" type="EIF_REFERENCE">If `compare_to' is `referers_target' then we add enclosing.</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_private void internal_find_referers (EIF_REFERENCE enclosing, EIF_REFERENCE compare_to)
{
	if
		((enclosing != compare_to) &&
		(referers_target == compare_to ? 1 : 0))
	{
		obj_array_extend (enclosing, found_collection);
	}
}

/*
doc:	<routine name="matching" return_type="EIF_REFERENCE" export="private">
doc:		<summary>Using `action_fnptr' find all objects where `action_fnptr' returns a matching object. Return a SPECIAL [ANY] of type `result_type' with all found references.</summary>
doc:		<param name="action_fnptr" type="void (*) (EIF_REFERENCE, EIF_REFERENCE)">Agent to be called for each object we find.</param>
doc:		<param name="result_type" type="int">Full dynamic type of SPECIAL [ANY].</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_private EIF_REFERENCE matching (void (*action_fnptr) (EIF_REFERENCE, EIF_REFERENCE), int result_type)
{
	int i = 0;
	struct obj_array l_found, l_marked;
	union overhead *zone;
	uint32 flags;
	EIF_REFERENCE Result;
	EIF_REFERENCE ref;
	
		/* Initialize structure that will hold found objects */
	l_found.count = 0;
	l_found.capacity = 64;
	l_found.area = malloc (sizeof (EIF_REFERENCE) * l_found.capacity);
	l_found.index = -1;
	found_collection = &l_found;

		/* Initialize structure that will hold marked objects */
	l_marked.count = 0;
	l_marked.capacity = 64;
	l_marked.area = malloc (sizeof (EIF_REFERENCE) * l_marked.capacity);
	l_marked.index = -1;
	marked_collection = &l_marked;

		/* Traverse all stacks and root object to find objects matching `action_fnptr'. */
	match_object (root_obj, action_fnptr);

#ifndef EIF_THREADS
#ifdef ISE_GC
	match_simple_stack (&hec_saved, action_fnptr);
	match_simple_stack (&hec_stack, action_fnptr);

	match_stack (&loc_set, action_fnptr);
	match_stack (&loc_stack, action_fnptr);
#endif
#ifdef WORKBENCH
	match_simple_stack (&once_set, action_fnptr);
#else
	match_stack (&once_set, action_fnptr);
#endif
	match_stack (&oms_set, action_fnptr);
#else
	for (i = 0; i < hec_saved_list.count; i++)
		match_simple_stack(hec_saved_list.threads.sstack[i], action_fnptr);
	for (i = 0; i < hec_stack_list.count; i++)
		match_simple_stack(hec_stack_list.threads.sstack[i], action_fnptr);

	for (i = 0; i < loc_set_list.count; i++)
		match_stack(loc_set_list.threads.sstack[i], action_fnptr);
	for (i = 0; i < loc_stack_list.count; i++)
		match_stack(loc_stack_list.threads.sstack[i], action_fnptr);

	match_stack(&global_once_set, action_fnptr);

	for (i = 0; i < once_set_list.count; i++)
		match_simple_stack(once_set_list.threads.sstack[i], action_fnptr);
#endif

		/* Now `l_found' is properly populated so let's create
		 * SPECIAL objects of type `result_type' that we will return.
		 * We turn off GC since we do not want objects to be moved. */
	gc_stop();
	Result = spmalloc (CHRPAD ((rt_uint_ptr) l_found.count * (rt_uint_ptr) sizeof (EIF_REFERENCE)) + LNGPAD(2), EIF_FALSE);
	zone = HEADER (Result);
	ref = Result + (zone->ov_size & B_SIZE) - LNGPAD (2);
	zone->ov_flags |= result_type | EO_REF;
	*(EIF_INTEGER *) ref = l_found.count;
	*(EIF_INTEGER *) (ref + sizeof (EIF_INTEGER)) = sizeof (EIF_REFERENCE);

		/* Now, populate `Result' with content of `l_found'. Since we just
		 * created a new Eiffel objects. */
	for (i = 0 ; i < l_found.count ; i++) {
		
			/* Store object in `Result'. */
		*((EIF_REFERENCE*) Result + i) = l_found.area [i];
		RTAR(Result, l_found.area [i]);
	}

		/* Now, we reset all EO_STORE flags. */
	for (i = 0 ; i < l_marked.count ; i++) {
			/* Reset `EO_STORE' flags */
		zone = HEADER(l_marked.area [i]);
		flags = zone->ov_flags;
		zone->ov_flags &= (~EO_STORE);
	}

	free (l_found.area);
	free (l_marked.area);

		/* Let's turn back the GC on */
	gc_run ();

	return Result;
} 

/*
doc:	<routine name="match_simple_stack" export="private">
doc:		<summary>Using `action_fnptr' find all objects where `action_fnptr' returns a matching object for objects located in simple stacks.</summary>
doc:		<param name="stk" type="struct stack *">Stack in which we are searching.</param>
doc:		<param name="action_fnptr" type="void (*) (EIF_REFERENCE, EIF_REFERENCE)">Agent to be called for each object we find.</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_private void match_simple_stack (struct stack *stk, void (*action_fnptr) (EIF_REFERENCE, EIF_REFERENCE))
{
	struct stchunk* s;
	EIF_REFERENCE *object, o_ref;
	int done = 0;
	rt_uint_ptr n;

	for (s = stk->st_hd ; s && !done; s = s->sk_next) {
		object = s->sk_arena;
		if (s != stk->st_cur) {
			n = s->sk_end -  object;
		} else {
			n = stk->st_top -object;
			done = 1;
		}
		for ( ; n > 0 ; n--, object++) {
			o_ref = *object;
			if (o_ref) {
				match_object (o_ref, action_fnptr);
			}
		}
	}
}

/*
doc:	<routine name="match_stack" export="private">
doc:		<summary>Using `action_fnptr' find all objects where `action_fnptr' returns a matching object for objects located in stacks.</summary>
doc:		<param name="stk" type="struct stack *">Stack in which we are searching.</param>
doc:		<param name="action_fnptr" type="void (*) (EIF_REFERENCE, EIF_REFERENCE)">Agent to be called for each object we find.</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_private void match_stack (struct stack *stk, void (*action_fnptr) (EIF_REFERENCE, EIF_REFERENCE))
{
	struct stchunk* s;
	EIF_REFERENCE *object, o_ref;
	int done = 0;
	rt_uint_ptr n;

	for (s = stk->st_hd ; s && !done; s = s->sk_next) {
		object = s->sk_arena;
		if (s != stk->st_cur) {
			n = s->sk_end -  object;
		} else {
			n = stk->st_top -object;
			done = 1;
		}
		for ( ; n > 0 ; n--, object++) {
			o_ref = *(EIF_REFERENCE *) *object;
			if (o_ref) {
				match_object (o_ref, action_fnptr);
			}
		}
	}
}

/*
doc:	<routine name="match_object" export="private">
doc:		<summary>Using `action_fnptr' find all objects where `action_fnptr' returns a matching object for objects located in stacks. Performs a recursive call for every references found in `object'.</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object we use for comparison.</param>
doc:		<param name="action_fnptr" type="void (*) (EIF_REFERENCE, EIF_REFERENCE)">Agent to be called for each object we find.</param>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Safe if caller holds the `eif_gc_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_private void match_object (EIF_REFERENCE object, void (*action_fnptr) (EIF_REFERENCE, EIF_REFERENCE))
{
	EIF_REFERENCE *o_ref;
	EIF_INTEGER count;
	union overhead *zone;
	uint32 flags;

	zone = HEADER(object);
	flags = zone->ov_flags;

	if ((flags & EO_C) || (flags & EO_STORE)) {
		/* Object is already marked, so we skip it. */
		return;
	}

		/* Insert Current object in case criterion `action_fnptr' needs it. */
	action_fnptr (object, object);

		/* Insert object in `marked_collection' so that we can remove the EO_STORE flag
		 * later on. */
	obj_array_extend (object, marked_collection);
	zone->ov_flags |= EO_STORE;	/* We marked object as traversed. */

	if (flags & EO_SPEC) {	/* Special object */
		if (!(flags & EO_REF))	/* Object does not have any references. */
			return;
		CHECK ("Not a SPECIAL of expanded objects", !(flags & EO_COMP));

		if (flags & EO_TUPLE) {
			EIF_TYPED_ELEMENT *l_item = (EIF_TYPED_ELEMENT *) object;
				/* Don't forget that first element of TUPLE is just a placeholder
				 * to avoid offset computation from Eiffel code */
			l_item++;
			count = RT_SPECIAL_COUNT(object) - 1;
			for (; count > 0; count--, l_item++) {
				if
					((eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE) &&
					(eif_reference_tuple_item(l_item)))
				{
					action_fnptr (object, eif_reference_tuple_item(l_item));
					match_object (eif_reference_tuple_item(l_item), action_fnptr);
				}
			}
			return;
		} else {
			count = *(EIF_INTEGER *) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
		}
	} else {
		count = References(Deif_bid(flags));
	}

		/* Perform recursion on enclosed references */
	for (o_ref = (EIF_REFERENCE *) object; count > 0; count--, o_ref++) {
		if (*o_ref != NULL) {
			action_fnptr (object, *o_ref);
			match_object (*o_ref, action_fnptr);
		}
	}
}

#ifdef DEBUG

rt_shared uint32 nomark(char *obj)
{
	/* Check if there is no object marked EO_STORE under `obj'. */
	struct htable *tbl;
	uint32 result;
	char gc_stopped;

	gc_stopped = !gc_ison();
	gc_stop();

	tbl = (struct htable *) cmalloc(sizeof(struct htable));
	if (tbl == (struct htable *) 0)
		enomem();
	if (ht_create(tbl, 1000, sizeof(char *)) != 0)
		enomem();
	result = chknomark(obj,tbl,0);
	ht_free(tbl);
	if (!gc_stopped) gc_run();
	return result;
}

rt_private uint32 chknomark(char *object, struct htable *tbl, uint32 object_count)
{
	/* First pass of the store mechanism consisting in marking objects. */

	char *object_ref, *reference;
	EIF_INTEGER count, elem_size;
	union overhead *zone = HEADER(object);		/* Object header */
	uint32 flags;								/* Object flags */
	unsigned long key = ((unsigned long) object) - 1;

	flags = zone->ov_flags;

	/* Stop on C objects */
	if (flags & EO_C)
		return object_count;

	/* Check if the object is already checked */
	if (ht_value(tbl,key) != (char *) 0)
		return object_count;

	/* Mark the object if not expanded */
	if (!(flags & EO_EXP)) {
		if (ht_put(tbl,key,object) == (char *) 0) {
			ht_xtend(tbl);
			if (ht_put(tbl,key,object) == (char *) 0)
				eif_panic("insertion trouble");
		}
		object_count++;
	}

	/* Check if no mark */
	if (flags & EO_STORE)
		eif_panic("object still marked");

	/* Evaluation of the number of references of the object */
	if (flags & EO_SPEC) {
		/* Special object */
		if (!(flags & EO_REF))
			/* Special object filled with direct instances */
			return object_count;

		/* Evaluation of the number of items in the special object */
		object_ref = RT_SPECIAL_INFO_WITH_ZONE(object, zone);
		count = RT_SPECIAL_COUNT_WITH_INFO(object_ref);

		if (flags & EO_TUPLE) {
			EIF_TYPED_ELEMENT *l_item = (EIF_TYPED_ELEMENT *) object;
				/* Don't forget that first element of TUPLE is just a placeholder
				 * to avoid offset computation from Eiffel code */
			l_item++;
			count--;
			for (; count > 0; count--, l_item++) {
				if
					((eif_tuple_item_type(l_item) == EIF_REFERENCE_CODE) &&
				 	(eif_reference_tuple_item(l_item)))
				{
					object_count = chknomark(eif_reference_tuple_item(l_item), tbl, object_count);	
				}
			}
		} else if (!(flags & EO_COMP)) {
			/* Special object filled with references */
			for (; count > 0; count--,
					object = (char *) ((char **) object + 1)) {
				reference = *(char **)object;
				if (0 != reference)
					/* Non void reference */
					object_count = chknomark(reference,tbl,object_count);					
			}
		} else {
			/* Special object filled with expanded objects which are
			 * necessary not special objects.
			 */
			elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(object_ref);
			for (object += OVERHEAD; count > 0;
					count --, object += elem_size)
				object_count = chknomark(object,tbl,object_count);
		}
	} else {
		/* Normal object */
		count = References(Deif_bid(flags));

		/* Traversal of references of `object' */
		for (;  count > 0;
				count--, object = (char *) (((char **) object) +1)) {
			reference = *(char **)object;
			if (((char *) 0) != reference)
				object_count = chknomark(reference,tbl,object_count);
		}
	}
	return object_count;
}
#endif

/*
doc:</file>
*/
