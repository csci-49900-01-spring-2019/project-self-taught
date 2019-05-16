class NotebooksController < MainSiteBaseController	
	def index
		# Public Notebooks Viewing
		@notebooks = Notebook.any_of({ private: false })
	end

	def user
		# User-filtered Notebooks Viewing
		begin
			@user = User.find(params[:user_id])
			@owner = (current_user.try(:id).to_s == params[:user_id])
			@notebooks = Notebook.where(owner: @user[:id])
		rescue => ex
			# 404 Error if user_id is not a registered user
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def show
		# Single-Notebook Viewing
		begin
			@notebook = Notebook.find(params[:notebook_id])
			@owner = current_user.try(:id) == @notebook.owner
			if @owner or !@notebook.private
				@notes = Note.where(notebook: @notebook.id)
				@questions = Question.where(notebook: @notebook.id)
				@tests = Test.where(notebook: @notebook.id)
				if !@owner
					@notes = @notes.where(private: false)
					@questions = @questions.where(private: false)
					@tests = @tests.where(private: false)
				end
			else
				# 401 Error if user is not allowed to view the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def new
		# Notebook Creation Page
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end
	end

	def create
		# Notebook Creation to the Database
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end
		current_user.create_notebook(params[:notebook_name], params[:notebook_description], params[:notebook_tags], params[:notebook_private] ? "true" : "false")
		redirect_to(user_notebooks_path(current_user[:id]))
	end

	def edit
		# Notebook Edit Page
		if !user_signed_in?
			# Only signed in users can attempt this
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@owner = current_user
			if !@notebook.user_auth?(@owner.id)
				# 401 Error if user is not allowed to view the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def update
		# Notebook Edit to the Database
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@owner = current_user
			if @owner.id != @notebook.owner
				# 401 Error if user is not allowed to view the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end

			@notebook.update_notebook(current_user.id, params[:notebook_name], params[:notebook_description], params[:notebook_tags], params[:notebook_private] ? "true" : "false")
			redirect_to(user_notebooks_path(current_user[:id]))
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def destroy
		# Notebook Deletion from the Database
		if !user_signed_in?
			# Only signed in users can attempt this
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@owner = current_user
			if @notebook.user_auth?(@owner.id)
				@notebook.delete_notebook()
				redirect_to(user_notebooks_path(current_user[:id]))
			else
				# 401 Error if user is not allowed to view the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end
end
