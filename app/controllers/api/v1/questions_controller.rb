class Api::V1::QuestionsController < Api::ApiBaseController
	before_action :authenticate_user!
	
	def index
		# Notebook-filtered Questions Viewing
		begin
			notebook_model = Notebook.find(params[:notebook_id])
			if !(notebook_model.can_view?(current_user.id))
				# 401 Error if user is not allowed to view the notebook
				render json: "not allowed to view this notebook", :status => :unauthorized
			end
			
			questions = Question.where(:id.in => notebook_model.question_ids())
			render json: questions ? questions.any_of({ owner: current_user.id }, { private: false }) : nil
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook does not exists", :status => :not_found
		end
	end

	def show
		# Single-Question Viewing
		begin
			notebook_model = Notebook.find(params[:notebook_id])
			question_model = Question.find(params[:question_id])
			if !(question_model.can_view?(current_user.id, notebook_model.id))
				# 401 Error if user is not allowed to access the question
				render json: "not allowed to view this question", :status => :unauthorized
			end
			
			render json: question_model
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook or question does not exists", :status => :not_found
		end
	end

	def user
		# User-filtered Questions Viewing
		begin
			user_model = User.find(params[:user_id])
			notebook_collection = user_model.notebook_models(current_user.id)
			questions = nil
			if notebook_collection
				notebook_collection.each do |notebook_model|
					question_collection = notebook_model.question_models(current_user.id)
					if question_collection
						if questions
							questions.merge(question_collection)
						else
							questions = question_collection
						end
					end
				end
			end
			render json: questions
		rescue => ex
			# 404 Error if user_id is not a registered user
			render json: "user does not exists", :status => :not_found
		end
	end

	def create
		# Question Creation to the Database
		begin
			notebook_model = Notebook.find(params[:notebook_id])
			if !(notebook_model.can_create_question? current_user.id)
				# 401 Error if user is not allowed to create a question
				render json: "not allowed to create a question", :status => :unauthorized
			end
			
			render json: notebook_model.create_question(params[:content], params[:answer], params[:tags], params[:private])
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook does not exists", :status => :not_found
		end
	end
	
	def update
		# Question Edit to the Database
		begin
			notebook_model = Notebook.find(params[:notebook_id])
			question_model = Question.find(params[:question_id])
			if !(question_model.user_auth?(current_user.id, notebook_model.id))
				# 401 Error if user is not allowed to access the question
				render json: "not allowed to access this question", :status => :unauthorized
			end
			
			render json: question_model.update_question(current_user.id, notebook_model.id, params[:content], params[:answer], params[:tags], params[:private])
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook or question does not exists", :status => :not_found
		end
	end

	def destroy
		# Question Deletion from the Database
		begin
			notebook_model = Notebook.find(params[:notebook_id])
			question_model = Question.find(params[:question_id])
			if !(question_model.user_auth?(current_user.id, notebook_model.id))
				# 401 Error if user is not allowed to access the question
				render json: "not allowed to access this question", :status => :unauthorized
			end
			
			render json: question_model.delete_question()
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook or question does not exists", :status => :not_found
		end
	end
end