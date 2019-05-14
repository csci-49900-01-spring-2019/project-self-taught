class Api::V1::NotebooksController < Api::ApiBaseController
	before_action :authenticate_user!
	
	def index
		render json: Notebook.first
	end
end