note
	description: "[
		Manages a hash_table of sessions.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_SESSION_MANAGER

create
	make

feature {NONE} -- Initialzation

	make
			-- Initialization for `Current'.
		do
			create sessions.make (16)
		ensure
			sessions_attached: sessions /= Void
		end

feature -- Access

	sessions: HASH_TABLE [XH_SESSION, STRING]
		-- The table of sessions

feature -- Basic operations

	get_current_session (a_request: XH_REQUEST; a_response: XH_RESPONSE): XH_SESSION
			-- Returns the session that belongs to the request.
			-- If the request does not contain any information regarding a session
			-- a new one is created which is noted in the response
		require
			a_request_attached: a_request /= Void
			a_response_attached: a_response /= Void
		local
			l_session: detachable like get_current_session
		do
			if attached a_request.cookies [{XU_CONSTANTS}.Cookie_uuid] as l_cookie then
				l_session := sessions.item (l_cookie.value)
				if l_session /= Void and then not l_session.has_expired then
					renew_session (l_session, a_response)
				end
			end
			if l_session /= Void then
				Result := l_session
			else
				Result := new_session (a_response)
			end
		ensure
			Result_attached: Result /= Void
		end

	renew_session (a_session: XH_SESSION ; a_response: XH_RESPONSE)
			-- Updates max_age of the session
		require
			a_session_attached: a_session /= Void
			a_response_attached: a_response /= Void
		local
			l_cookie_order: XH_COOKIE_ORDER
		do
			create l_cookie_order.make ({XU_CONSTANTS}.Cookie_uuid, a_session.uuid)
			l_cookie_order.max_age := a_session.max_age
			a_response.put_cookie_order (l_cookie_order)
		end

	new_session (a_response: XH_RESPONSE): XH_SESSION
			-- Startes a new session and adds it to the table
		require
			a_response_attached: a_response /= Void
		local
			l_session: XH_SESSION
			l_cookie_order: XH_COOKIE_ORDER
		do
			create l_session.make
			l_session.max_age := 1000
			sessions.put (l_session, l_session.uuid)
			Result := l_session

			create l_cookie_order.make ({XU_CONSTANTS}.Cookie_uuid, l_session.uuid)
			l_cookie_order.max_age := 1000
			a_response.put_cookie_order (l_cookie_order)
		ensure
			Result_attached: Result /= Void
		end

invariant
	sessions_attached: sessions /= Void

end
