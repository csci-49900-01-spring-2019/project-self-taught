class NotebooksController < SiteBaseController
	def show #Shows the contents and description of a single notebook
		if user_signed_in?
			@user = current_user
		end
		@notebook = Notebook.find(params[:id])
		@notes = @notebook.note_array
		@tests = @notebook.test_array
		respond_to do |format|
      format.html
      format.json { render :json => @notebook}
    end
	end

	def user #GET Notebooks of a specific user
		@user = User.find(params[:id])
		if @user
			@notebooks = @user.notebook_array
		end
	end

	def new #GET Page for creating a new notebook
		if user_signed_in?
			@notebook = Notebook.new
			render :new
		else
			redirect_to('/users/sign_in')
		end
	end

	def create #POST for a notebook creation
		if user_signed_in?
			@user = current_user
			@user.notebook_create(notebook_params)
			redirect_to(user_notebooks_path(current_user[:id]))
		else
			redirect_to('/users/sign_in')
		end
	end

	def edit #GET for notebook editing
		if user_signed_in?
			@user = current_user
			@notebook = Notebook.find(params[:id])
			if @user.notebook_owner?(@notebook.id)
			else
			end
		else
			redirect_to('/users/sign_in')
		end
	end

	def update #PUT & PATCH for saving notebook edits
		if user_signed_in?
			@user = current_user
			@notebook = Notebook.find(params[:id])
			if @user.notebook_owner?(@notebook.id)
				@notebook.update(notebook_params)
				redirect_to(user_notebooks_path(current_user[:id]))
			end
		else
			redirect_to('/users/sign_in')
		end
	end

	def destroy #DELETE for a notebook deletion
		if user_signed_in?
			@user = current_user
			@user.notebook_delete(params[:id])
		else
		end
	end
	
	def notebook_params
		params.require(:notebook).permit(:name)
	end

end
