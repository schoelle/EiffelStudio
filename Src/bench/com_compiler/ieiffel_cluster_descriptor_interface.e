indexing
	description: "Eiffel Cluster Descriptor.  Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	name_user_precondition: BOOLEAN is
			-- User-defined preconditions for `name'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	description_user_precondition: BOOLEAN is
			-- User-defined preconditions for `description'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	classes_user_precondition: BOOLEAN is
			-- User-defined preconditions for `classes'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	class_count_user_precondition: BOOLEAN is
			-- User-defined preconditions for `class_count'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	clusters_user_precondition: BOOLEAN is
			-- User-defined preconditions for `clusters'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	cluster_count_user_precondition: BOOLEAN is
			-- User-defined preconditions for `cluster_count'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	cluster_path_user_precondition: BOOLEAN is
			-- User-defined preconditions for `cluster_path'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	name: STRING is
			-- Cluster name.
		require
			name_user_precondition: name_user_precondition
		deferred

		end

	description: STRING is
			-- Cluster description.
		require
			description_user_precondition: description_user_precondition
		deferred

		end

	classes: IENUM_CLASS_INTERFACE is
			-- List of classes in cluster.
		require
			classes_user_precondition: classes_user_precondition
		deferred

		end

	class_count: INTEGER is
			-- Number of classes in cluster.
		require
			class_count_user_precondition: class_count_user_precondition
		deferred

		end

	clusters: IENUM_CLUSTER_INTERFACE is
			-- List of subclusters in cluster.
		require
			clusters_user_precondition: clusters_user_precondition
		deferred

		end

	cluster_count: INTEGER is
			-- Number of subclusters in cluster.
		require
			cluster_count_user_precondition: cluster_count_user_precondition
		deferred

		end

	cluster_path: STRING is
			-- Full path to cluster.
		require
			cluster_path_user_precondition: cluster_path_user_precondition
		deferred

		end

end -- IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE

