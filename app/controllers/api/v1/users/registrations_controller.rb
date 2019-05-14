module Api::V1
	class Users::RegistrationsController < DeviseTokenAuth::RegistrationsController
		include DeviseTokenAuth::Concerns::SetUserByToken
		protect_from_forgery with: :null_session
	end
end