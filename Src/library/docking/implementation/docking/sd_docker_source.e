indexing
	description: "SD_ZONE which dockable SD_ZONE should inherited, used by SD_DOCKER_MEDIATOR"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_DOCKER_SOURCE

feature -- Key feature.

	add_hot_zones (a_docker_mediator: SD_DOCKER_MEDIATOR; a_hot_zones: ARRAYED_LIST [SD_HOT_ZONE]) is
			-- Add hot zones
		require
			a_docker_mediator_not_void: a_docker_mediator /= Void
			a_hot_zones_not_void: a_hot_zones /= Void
		local
			l_zone: SD_ZONE
		do
			l_zone ?= Current
			check l_zone /= Void end
			a_hot_zones.extend (internal_shared.hot_zone_factory.hot_zone (l_zone))
		end

feature {NONE}  -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_shared_not_void: internal_shared /= Void

end
