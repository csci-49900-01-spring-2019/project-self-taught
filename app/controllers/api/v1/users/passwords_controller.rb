module Api::V1
	class Users::PasswordsController < DeviseTokenAuth::PasswordsController
		include DeviseTokenAuth::Concerns::SetUserByToken
		protect_from_forgery with: :null_session
	end
end