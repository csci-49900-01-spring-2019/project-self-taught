module Api::V1
	class Users::TokenValidationsController < DeviseTokenAuth::TokenValidationsController
		include DeviseTokenAuth::Concerns::SetUserByToken
		protect_from_forgery with: :null_session
	end
end