class UsersController < ApplicationController
	def new
		@navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
	end

	def access
		@navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
	end
end