class HomepageController < ApplicationController
	def index
		@navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
	end
end