class NotesController < MainSiteBaseController
	def show
		@note = Note.find(params[:id])
		respond_to do |format|
      format.html
      format.json { render :json => @note}
    end
	end

	def user
		@user = User.where(username: params[:id]).first
		if @user
			@notebooks = @user.notebook_array
			@notes = []
			@notebooks.each do |notebook|
				@notes += notebook.note_array
			end
			respond_to do |format|
				format.html
				format.json { render :json => @notes}
			end
		end
	end

	def new
		if user_signed_in?
			@note = Note.new
			render :new
		else
			redirect_to('/users/sign_in')
		end
	end

	def create
		if user_signed_in?
			@user = User.where(username: current_user[:username]).first
			@notebook = Notebook.find(params[:notebook_id])
			@notebook.note_create(note_params, @user.id, @notebook.id)
			redirect_to(notebook_path(params[:notebook_id]))
		else
			redirect_to('/users/sign_in')
		end
	end

	def edit #GET for notebook editing
		if user_signed_in?
			@user = User.where(username: current_user[:username]).first
			@notebook = Notebook.find(params[:notebook_id])
			@note = Note.find(params[:id])
			if @user.notebook_owner?(@notebook.id) && @notebook.note_owner?(@note.id)
			else
			end
		else
			redirect_to('/users/sign_in')
		end
	end

	def update #PUT & PATCH for saving note edits
		if user_signed_in?
			@user = User.where(username: current_user[:username]).first
			@notebook = Notebook.find(params[:notebook_id])
			@note = Note.find(params[:id])
			if @user.notebook_owner?(@notebook.id) && @notebook.note_owner?(@note.id)
				@note.update(note_params)
				redirect_to(notebook_path(params[:notebook_id]))
			end
		else
			redirect_to('/users/sign_in')
		end
	end

	def destroy #DELETE for a note deletion
		if user_signed_in?
			@notebook = Notebook.find(params[:notebook_id])
			@notebook.note_delete(params[:id])
		else
		end
	end

	def note_params
		params.require(:note).permit(:name)
	end
end
