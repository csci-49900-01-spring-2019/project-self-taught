class ApplicationController < ActionController::Base
	#has_mobile_fu #Mobile Device Detection
	# Devise configuration
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :gender, :grade])
		devise_parameter_sanitizer.permit(:sign_in) do |user_params|
			user_params.permit(:username)
		end
	end
	#
	
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


end
