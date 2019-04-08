class ApplicationController < ActionController::Base
	#has_mobile_fu #Mobile Device Detection
	
	module Navbar
		FOOTER =		1 << 0
		LEFT_MENU = 1 << 1
		HALF_TOP = 1 << 2
		FULL_TOP =  1 << 3
	end

	module ViewType
		DESKTOP = 1 << 0
		MOBILE = 1 << 1
		TABLET = 1 << 2
	end

	$app_title = "Self-Taught"
	# The navigation bar flag
	# @navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
end

