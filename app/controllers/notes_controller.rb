class NotesController < MainSiteBaseController
	def index
		# Public Notes Viewing
		@notebooks = Notebook.any_of({ private: false })
		
		if @notebooks
			@notebooks.each do |notebook|
				notes2 = Note.any_of({ notebook: notebook.id.to_s, private: false })
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
			if !((@owner.id == @notebook.owner  or (!@notebook.private and !@note.private)) and @note.notebook == @notebook.id.to_s)
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

			@entry_owner = current_user[:id]
			@entry_notebook = params[:notebook_id]
			
			@entry_name = params[:note_name]
			
			@entry_description = params[:note_description]

			if params[:note_tags]
				@entry_tags = params[:note_tags].split(",")
				@entry_tags.map! { |tag| tag = tag.strip }
			end
			if !@entry_tags
				@entry_tags = []
			end

			if params[:note_private]
				@entry_private = true
			else
				@entry_private = false
			end

			@note = Note.create(owner: @entry_owner, notebook: @entry_notebook, name: @entry_name, description: @entry_description, tags: @entry_tags, private: @entry_private)
			if !@notebook.notes
				@notebook.notes = []
			end
			@notebook.notes.push(@note.id)
			@notebook.update(notes: @notebook.notes)

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
			if !(@owner.id == @notebook.owner and @note.notebook == @notebook.id.to_s)
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
			if !(@owner.id == @notebook.owner and @note.notebook == @notebook.id.to_s)
				# 401 Error if user is not allowed to view the notebook or if the note does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		
			@entry_owner = current_user[:id]
			
			@entry_name = params[:note_name]
			
			@entry_description = params[:note_description]

			if params[:note_tags]
				@entry_tags = params[:note_tags].split(",")
				@entry_tags.map! { |tag| tag = tag.strip }
			end
			if !@entry_tags
				@entry_tags = []
			end

			if params[:note_private]
				@entry_private = true
			else
				@entry_private = false
			end

			@note.update(owner: @entry_owner, name: @entry_name, description: @entry_description, tags: @entry_tags, private: @entry_private)
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
			if @owner.id == @notebook.owner and @note.notebook == @notebook.id.to_s
				@note.delete
				@notebook.notes.delete(@note.id)
				@notebook.update(notes: @notebook.notes)
				
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
