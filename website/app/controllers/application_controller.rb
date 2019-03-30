class ApplicationController < ActionController::Base
	#has_mobile_fu #Mobile Device Detection

	# Navigation Bar
	module Navbar
		SITE_FOOTER =		1 << 0
		INFO_NAV_TOP =  1 << 1
	end

	# The navigation bar flag
	# @navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
end
