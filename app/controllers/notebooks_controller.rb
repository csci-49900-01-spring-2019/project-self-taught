class NotebooksController < MainSiteBaseController	
	def user
		# User-filtered Notebooks Viewing
		begin
			@user = User.find(params[:user_id])
			@owner = (current_user.try(:id).to_s == params[:user_id])
			@notebooks = Notebook.where(owner: @user[:id])
		rescue => ex
			# 404 Error if user_id is not a registered user
			render :file => "#{Rails.root}/public/404", :layout => "application", :status => :not_found
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
		
		@entry_owner = current_user[:id]
		
		@entry_name = params[:notebook_name]
		
		@entry_description = params[:notebook_description]

		if params[:notebook_tags]
			@entry_tags = params[:notebook_tags].split(",")
			@entry_tags.map! { |tag| tag = tag.strip }
		end
		if !@entry_tags
			@entry_tags = []
		end

		if params[:notebook_private]
			@entry_private = true
		else
			@entry_private = false
		end

		Notebook.create(owner: @entry_owner, name: @entry_name, description: @entry_description, tags: @entry_tags, private: @entry_private)
		redirect_to(user_notebooks_path(current_user[:id]))
	end
	
	def show
		# Contents
		if user_signed_in?
			@user = User.where(username: current_user[:username]).first
		end
		@notebook = Notebook.find(params[:id])
		@notes = @notebook.note_array
		@tests = @notebook.test_array
		respond_to do |format|
      format.html
      format.json { render :json => @notebook}
    end
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
			if @owner.id != @notebook.owner
				# 401 Error if user is not the notebook owner
				render :file => "public/401.html", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if user_id is not a registered user
			render :file => "#{Rails.root}/public/404", :layout => "application", :status => :not_found
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
		
			@entry_owner = current_user[:id]
			
			@entry_name = params[:notebook_name]
			
			@entry_description = params[:notebook_description]

			if params[:notebook_tags]
				@entry_tags = params[:notebook_tags].split(",")
				@entry_tags.map! { |tag| tag = tag.strip }
			end
			if !@entry_tags
				@entry_tags = []
			end

			if params[:notebook_private]
				@entry_private = true
			else
				@entry_private = false
			end

			
			@notebook.update(owner: @entry_owner, name: @entry_name, description: @entry_description, tags: @entry_tags, private: @entry_private)
			redirect_to(user_notebooks_path(current_user[:id]))
		rescue => ex
			# 404 Error if user_id is not a registered user
			render :file => "#{Rails.root}/public/404", :layout => "application", :status => :not_found
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
			if @owner.id == @notebook.owner
				@notebook.delete
				redirect_to(user_notebooks_path(current_user[:id]))
			else
				# 401 Error if user is not the notebook owner
				render :file => "public/401.html", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if user_id is not a registered user
			render :file => "#{Rails.root}/public/404", :layout => "application", :status => :not_found
		end
	end
	
	def notebook_params
		params.require(:notebook).permit(:name)
	end

end
