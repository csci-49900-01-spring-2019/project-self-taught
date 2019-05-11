class Api::ApiBaseController < ApplicationController
	include DeviseTokenAuth::Concerns::SetUserByToken
	protect_from_forgery with: :null_session
end