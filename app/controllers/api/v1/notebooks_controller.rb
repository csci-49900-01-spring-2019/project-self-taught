class Api::V1::NotebooksController < Api::ApiBaseController
	before_action :authenticate_user!
	
	def index
		# Public Notebooks Viewing
		render json: Notebook.any_of({ private: false })
	end

	def user
		# User-filtered Notebooks Viewing
		begin
			@user = User.find(params[:user_id])
			render json: @user.notebook_models(current_user.id)
		rescue => ex
			# 404 Error if user_id is not a registered user
			render json: "user does not exists", :status => :not_found
		end
	end

	def create
		# Notebook Creation to the Database
		begin
			render json: current_user.create_notebook(params[:name], params[:description], params[:tags], params[:private])
		rescue => ex
			# 401 Error on bad user_auth or bad parameter
			render json: "bad parameter", :status => :unauthorized
		end
	end
	
	def update
		# Notebook Edit to the Database
		begin
			@notebook = Notebook.find(params[:notebook_id])
			if !(@notebook.user_auth? current_user.id)
				# 401 Error if user is not allowed to view the notebook
				render json: "not allowed to access this notebook", :status => :unauthorized
			end
			
			render json: @notebook.update_notebook(current_user.id, params[:name], params[:description], params[:tags], params[:private])
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook does not exists", :status => :not_found
		end
	end
end