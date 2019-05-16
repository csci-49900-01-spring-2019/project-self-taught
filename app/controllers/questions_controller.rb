class QuestionsController < MainSiteBaseController
	def index
		# Public Questions Viewing
		@notebooks = Notebook.any_of({ private: false })
		
		if @notebooks
			@notebooks.each do |notebook|
				questions2 = Question.any_of({ notebook: notebook.id, private: false })
				if @questions
					@questions.merge(questions2)
				else
					@questions = questions2
				end
			end
		end
		if !@questions
			@questions = []
		end
	end

	def show
		# Single-Question Viewing
		begin
			@notebook = Notebook.find(params[:notebook_id])
			@question = Question.find(params[:question_id])
			@owner = current_user
			if !(@question.can_view?(@owner.id, @notebook.id))
				# 401 Error if user is not allowed to view the notebook or if the question does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id or question_id is not a registered notebook or question
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def user
		# User-filtered Questions Viewing
		begin
			@user = User.find(params[:user_id])
			@owner = (current_user.try(:id).to_s == params[:user_id])
			@questions = Question.where(owner: @user[:id])
		rescue => ex
			# 404 Error if user_id is not a registered user
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def new
		# Question Creation Page
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def create
		# Question Creation to the Database
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end
		
		begin
			@notebook = Notebook.find(params[:notebook_id])
			@notebook.create_question(params[:question_content], params[:question_answer], params[:question_tags], params[:question_private] ? "true" : "false")
			redirect_to(notebook_path(params[:notebook_id]))
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def edit
		# Question Edit Page
		if !user_signed_in?
			# Only signed in users can attempt this
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@question = Question.find(params[:question_id])
			@owner = current_user
			if !(@question.user_auth?(@owner.id, @notebook.id))
				# 401 Error if user is not allowed to view the notebook or if the question does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id or question_id is not a registered notebook or question
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end
	
	def update
		# Question Edit to the Database
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@question = Question.find(params[:question_id])
			@owner = current_user
			if !(@question.user_auth?(@owner.id, @notebook.id))
				# 401 Error if user is not allowed to view the notebook or if the question does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		
			@question.update_question(current_user.id, @notebook.id, params[:question_content], params[:question_answer], params[:question_tags], params[:question_private] ? "true" : "false")
			redirect_to(notebook_path(params[:notebook_id]))
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def destroy
		# Question Deletion from the Database
		if !user_signed_in?
			# Only signed in users can attempt this
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@question = Question.find(params[:question_id])
			@owner = current_user
			if @question.user_auth?(@owner.id, @notebook.id)
				@question.delete_question()
				redirect_to(notebook_path(params[:notebook_id]))
			else
				# 401 Error if user is not allowed to view the notebook or if the question does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id or question_id is not a registered notebook or question
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end
end
