class NotebooksController < ApplicationController
	def user
		@userlogin = true
		@navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
	end
end