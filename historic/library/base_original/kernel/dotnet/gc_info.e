note

	description: "[
			Garbage collector statistics.
			This class may be used as ancestor by classes needing its facilities.
			Time accounting is relevant only if `enable_time_accounting' 
			(from MEMORY) has been called.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class GC_INFO inherit

	MEM_CONST

create

	make

feature -- Initialization

	make, update (memory: INTEGER)
			-- Fill in statistics for `memory' type
		do
			gc_stat (memory)
			cycle_count := gc_info (0)
			memory_used := gc_info (1)
			collected := gc_info (2)
			collected_average := gc_info (3)
			real_time := gc_info (4)
			real_time_average := gc_info (5)
			real_interval_time := gc_info (6)
			real_interval_time_average := gc_info (7)
			cpu_time := gc_infod (8)
			cpu_time_average := gc_infod (9)
			cpu_interval_time := gc_infod (10)
			cpu_interval_time_average := gc_infod (11)
			sys_time := gc_infod (12)
			sys_time_average := gc_infod (13)
			sys_interval_time := gc_infod (14)
			sys_interval_time_average := gc_infod (15)
		end

feature -- Access

	type: INTEGER
			-- Collector type (Full, Collect),
			-- for `type' before last call to `update'

	cycle_count: INTEGER
			-- Number of collection cycles for `type'
			-- before last call to `update'

	memory_used: INTEGER
			-- Total number of bytes used (counting overhead)
			-- after last cycle for `type' before last
			-- call to `update'

	collected: INTEGER
			-- Number of bytes collected by the last cycle,
			-- for `type' before last call to `update'

	collected_average: INTEGER
			-- Average number of bytes collected by a cycle,
			-- for `type' before last call to `update'

	real_time: INTEGER
			-- Real time in centi-seconds used by last cycle
			-- for `type', before last call to `update';
			-- this may not be accurate on systems which do not
			-- provide a sub-second accuracy clock (typically
			-- provided on BSD).

	real_time_average: INTEGER
			-- Average amount of real time, in centi-seconds,
			-- spent in collection cycle,
			-- for `type' before last call to `update'

	real_interval_time: INTEGER
			-- Real interval time (as opposed to CPU time) between
			-- two automatically raised cycles, in centi-seconds,
			-- for `type' before last call to `update'

	real_interval_time_average: INTEGER
			-- Average real interval time between two automatic
			-- cycles, in centi-seconds,
			-- for `type' before last call to `update'

	cpu_time: DOUBLE
			-- Amount of CPU time, in seconds, spent in cycle,
			-- for `type' before last call to `update'

	cpu_time_average: DOUBLE
			-- Average amount of CPU time spent in cycle,
			-- in seconds, for `type' before last call to `update'

	cpu_interval_time: DOUBLE
			-- Amount of CPU time elapsed since between last
			-- and penultimate cycles for `type' before
			-- last call to `update'

	cpu_interval_time_average: DOUBLE
			-- Average amount of CPU time between two cycles,
			-- for `type' before last call to `update'

	sys_time: DOUBLE
			-- Amount of kernel time, in seconds, spent in cycle,
			-- for `type' before last call to `update'

	sys_time_average: DOUBLE
			-- Average amount of kernel time spent in cycle,
			-- for `type' before last call to `update'

	sys_interval_time: DOUBLE
			-- Amount of kernel time elapsed since between
			-- the last and the penultimate cycle,
			-- for `type' before last call to `update'

	sys_interval_time_average: DOUBLE
			-- Average amount of kernel time between two cycles,
			-- for `type' before last call to `update'

feature {NONE} -- Implementation

	gc_stat (mem: INTEGER)
			-- Initialize run-time buffer used by gc_info to retrieve the
			-- statistics frozen at the time of this call.
		do
			check
				not_implemented: False
			end
		end

	gc_info (field: INTEGER): INTEGER
			-- Read GC accounting structure, field by field.
		do
			check
				not_implemented: False
			end
		end

	gc_infod (field: INTEGER): DOUBLE
			-- Read GC accounting structure, field by field.
		do
			check
				not_implemented: False
			end
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class GC_INFO



