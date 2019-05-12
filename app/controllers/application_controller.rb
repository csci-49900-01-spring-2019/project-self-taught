class ApplicationController < ActionController::Base
	#has_mobile_fu #Mobile Device Detection
	# Devise configuration
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :null_session

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :email, :gender, :grade])
		devise_parameter_sanitizer.permit(:sign_in) do |user_params|
			user_params.permit(:username)
		end
	end
	#
end
