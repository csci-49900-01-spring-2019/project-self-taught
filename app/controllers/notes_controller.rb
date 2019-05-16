class NotesController < MainSiteBaseController
	def index
		# Public Notes Viewing
		@notebooks = Notebook.any_of({ private: false })
		
		if @notebooks
			@notebooks.each do |notebook|
				notes2 = Note.any_of({ notebook: notebook.id, private: false })
				if @notes
					@notes.merge(notes2)
				else
					@notes = notes2
				end
			end
		end
		if !@notes
			@notes = []
		end
	end

	def show
		# Single-Note Viewing
		begin
			@notebook = Notebook.find(params[:notebook_id])
			@note = Note.find(params[:note_id])
			@owner = current_user
			if !(@note.can_view?(@owner.id, @notebook.id))
				# 401 Error if user is not allowed to view the notebook or if the note does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id or note_id is not a registered notebook or note
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def user
		# User-filtered Notes Viewing
		begin
			@user = User.find(params[:user_id])
			@owner = (current_user.try(:id).to_s == params[:user_id])
			@notes = Note.where(owner: @user[:id])
		rescue => ex
			# 404 Error if user_id is not a registered user
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def new
		# Note Creation Page
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
		# Note Creation to the Database
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end
		
		begin
			@notebook = Notebook.find(params[:notebook_id])
			@notebook.create_note(params[:note_name], params[:note_description], params[:note_tags], params[:note_private] ? "true" : "false")
			redirect_to(notebook_path(params[:notebook_id]))
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def edit
		# Note Edit Page
		if !user_signed_in?
			# Only signed in users can attempt this
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@note = Note.find(params[:note_id])
			@owner = current_user
			if !(@note.user_auth?(@owner.id, @notebook.id))
				# 401 Error if user is not allowed to view the notebook or if the note does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id or note_id is not a registered notebook or note
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end
	
	def update
		# Note Edit to the Database
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@note = Note.find(params[:note_id])
			@owner = current_user
			if !(@note.user_auth?(@owner.id, @notebook.id))
				# 401 Error if user is not allowed to view the notebook or if the note does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end

			@note.update_note(current_user.id, @notebook.id, params[:note_name], params[:note_description], params[:note_tags], params[:note_private] ? "true" : "false")
			redirect_to(notebook_path(params[:notebook_id]))
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def destroy
		# Note Deletion from the Database
		if !user_signed_in?
			# Only signed in users can attempt this
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@note = Note.find(params[:note_id])
			@owner = current_user
			if @note.user_auth?(@owner.id, @notebook.id)
				@note.delete_note()
				redirect_to(notebook_path(params[:notebook_id]))
			else
				# 401 Error if user is not allowed to view the notebook or if the note does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id or note_id is not a registered notebook or note
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end
end
