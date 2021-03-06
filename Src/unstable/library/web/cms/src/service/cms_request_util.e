note
	description: "Summary description for {CMS_REQUEST_UTIL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_REQUEST_UTIL

inherit

	CMS_ENCODERS

	REFACTORING_HELPER

feature -- User

	current_user_name (req: WSF_REQUEST): detachable READABLE_STRING_32
			-- Current user name or Void in case of Guest users.
		note
			EIS: "src=eiffel:?class=AUTHENTICATION_FILTER&feature=execute"
		do
			if attached {CMS_USER} current_user (req) as l_user then
				Result := l_user.name
			end
		end

	current_user (req: WSF_REQUEST): detachable CMS_USER
			-- Current user or Void in case of Guest user.
		note
			EIS: "eiffel:?class=AUTHENTICATION_FILTER&feature=execute"
		do
			if attached {CMS_USER} req.execution_variable ("user") as l_user then
				Result := l_user
			end
		end

feature -- Media Type

	current_media_type (req: WSF_REQUEST): detachable READABLE_STRING_32
			-- Current media type or Void if it's not acceptable.
		do
			if attached {STRING} req.execution_variable ("media_type") as l_type then
				Result := l_type
			end
		end

feature -- Absolute Host

	absolute_host (req: WSF_REQUEST; a_path:STRING): STRING
		do
			Result := req.absolute_script_url (a_path)
			if Result.last_index_of ('/', Result.count) = Result.count then
				Result.remove_tail (1)
			end
		end

end
