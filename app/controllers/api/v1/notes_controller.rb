class Api::V1::NotesController < Api::ApiBaseController
	before_action :authenticate_user!
	
	def index
		# Notebook-filtered Notes Viewing
		begin
			notebook_model = Notebook.find(params[:notebook_id])
			if !(notebook_model.can_view?(current_user.id))
				# 401 Error if user is not allowed to view the notebook
				render json: "not allowed to view this notebook", :status => :unauthorized
			end
			
			notes = Note.where(:id.in => notebook_model.note_ids())
			render json: notes ? notes.any_of({ owner: current_user.id }, { private: false }) : nil
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook does not exists", :status => :not_found
		end
	end

	def show
		# Single-Note Viewing
		begin
			notebook_model = Notebook.find(params[:notebook_id])
			note_model = Note.find(params[:note_id])
			if !(note_model.can_view?(current_user.id, notebook_model.id))
				# 401 Error if user is not allowed to access the note
				render json: "not allowed to view this note", :status => :unauthorized
			end
			
			render json: note_model
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook or note does not exists", :status => :not_found
		end
	end

	def user
		# User-filtered Notes Viewing
		begin
			user_model = User.find(params[:user_id])
			notebook_collection = user_model.notebook_models(current_user.id)
			notes = nil
			if notebook_collection
				notebook_collection.each do |notebook_model|
					note_collection = notebook_model.note_models(current_user.id)
					if note_collection
						if notes
							notes.merge(note_collection)
						else
							notes = note_collection
						end
					end
				end
			end
			render json: notes
		rescue => ex
			# 404 Error if user_id is not a registered user
			render json: "user does not exists", :status => :not_found
		end
	end

	def create
		# Note Creation to the Database
		begin
			notebook_model = Notebook.find(params[:notebook_id])
			if !(notebook_model.can_create_note? current_user.id)
				# 401 Error if user is not allowed to create a note
				render json: "not allowed to create a note", :status => :unauthorized
			end
			
			render json: notebook_model.create_note(params[:name], params[:description], params[:tags], params[:private])
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook does not exists", :status => :not_found
		end
	end
	
	def update
		# Note Edit to the Database
		begin
			notebook_model = Notebook.find(params[:notebook_id])
			note_model = Note.find(params[:note_id])
			if !(note_model.user_auth?(current_user.id, notebook_model.id))
				# 401 Error if user is not allowed to access the note
				render json: "not allowed to access this note", :status => :unauthorized
			end
			
			render json: note_model.update_note(current_user.id, notebook_model.id, params[:name], params[:description], params[:tags], params[:private])
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook or note does not exists", :status => :not_found
		end
	end

	def destroy
		# Notebook Deletion from the Database
		begin
			notebook_model = Notebook.find(params[:notebook_id])
			note_model = Note.find(params[:note_id])
			if !(note_model.user_auth?(current_user.id, notebook_model.id))
				# 401 Error if user is not allowed to access the note
				render json: "not allowed to access this note", :status => :unauthorized
			end
			
			render json: note_model.delete_note()
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render json: "notebook or note does not exists", :status => :not_found
		end
	end
end