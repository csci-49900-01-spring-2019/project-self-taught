module Api::V1
	class Users::SessionsController < DeviseTokenAuth::SessionsController
		include DeviseTokenAuth::Concerns::SetUserByToken
		protect_from_forgery with: :null_session
	end
end