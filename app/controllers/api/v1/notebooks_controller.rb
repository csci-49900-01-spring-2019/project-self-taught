class Api::V1::NotebooksController < Api::ApiBaseController
	before_action :authenticate_user!
	
	def index
		render json: Notebook.first
	end

	def user
		# User-filtered Notebooks Viewing
		begin
			@user = User.find(params[:user_id])
			render json: @user.notebook_models(current_user.id)
		rescue => ex
			# 404 Error if user_id is not a registered user
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end
end