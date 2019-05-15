class TestsController < MainSiteBaseController
	def index
		# Public Tests Viewing
		@notebooks = Notebook.any_of({ private: false })
		
		if @notebooks
			@notebooks.each do |notebook|
				tests2 = Test.any_of({ notebook: notebook.id.to_s, private: false })
				if @tests
					@tests.merge(tests2)
				else
					@tests = tests2
				end
			end
		end
		if !@tests
			@tests = []
		end
	end

	def show
		# Single-Test Viewing
		begin
			@notebook = Notebook.find(params[:notebook_id])
			@test = Test.find(params[:test_id])
			@owner = current_user
			if !((@owner.id == @notebook.owner  or (!@notebook.private and !@test.private)) and @test.notebook == @notebook.id.to_s)
				# 401 Error if user is not allowed to view the notebook or if the test does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id or test_id is not a registered notebook or test
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def user
		# User-filtered Tests Viewing
		begin
			@user = User.find(params[:user_id])
			@owner = (current_user.try(:id).to_s == params[:user_id])
			@tests = Test.where(owner: @user[:id])
		rescue => ex
			# 404 Error if user_id is not a registered user
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def new
		# Test Creation Page
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@questions = Question.where(:_id.in => @notebook.questions)
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def create
		# Test Creation to the Database
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end
		
		begin
			@notebook = Notebook.find(params[:notebook_id])

			@entry_owner = current_user[:id]
			@entry_notebook = params[:notebook_id]
			
			@entry_name = params[:test_name]
			@entry_description = params[:test_description]

			@entry_questions = []
			params.each do |param|
				if param[0].starts_with?("question-")
					@entry_questions.push(param[0][9..-1])
				end
			end

			@entry_time_limit = params[:test_time_limit].to_f

			if params[:test_tags]
				@entry_tags = params[:test_tags].split(",")
				@entry_tags.map! { |tag| tag = tag.strip }
			end
			if !@entry_tags
				@entry_tags = []
			end

			if params[:test_private]
				@entry_private = true
			else
				@entry_private = false
			end

			@test = Test.create(owner: @entry_owner, notebook: @entry_notebook, name: @entry_name, description: @entry_description, questions: @entry_questions, time_limit: @entry_time_limit, tags: @entry_tags, private: @entry_private)
			if !@notebook.tests
				@notebook.tests = []
			end
			@notebook.tests.push(@test.id)
			@notebook.update(tests: @notebook.tests)

			redirect_to(notebook_path(params[:notebook_id]))
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def edit
		# Test Edit Page
		if !user_signed_in?
			# Only signed in users can attempt this
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@test = Test.find(params[:test_id])
			@owner = current_user
			if !(@owner.id == @notebook.owner and @test.notebook == @notebook.id.to_s)
				# 401 Error if user is not allowed to view the notebook or if the test does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
			@questions = Question.where(:_id.in => @notebook.questions)
		rescue => ex
			# 404 Error if notebook_id or test_id is not a registered notebook or test
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end
	
	def update
		# Test Edit to the Database
		if !user_signed_in?
			# Only signed in users can access this page
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@test = Test.find(params[:test_id])
			@owner = current_user
			if !(@owner.id == @notebook.owner and @test.notebook == @notebook.id.to_s)
				# 401 Error if user is not allowed to view the notebook or if the test does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		
			@entry_owner = current_user[:id]
			@entry_notebook = params[:notebook_id]
			
			@entry_name = params[:test_name]
			@entry_description = params[:test_description]

			@entry_questions = []
			params.each do |param|
				if param[0].starts_with?("question-")
					@entry_questions.push(param[0][9..-1])
				end
			end

			@entry_time_limit = params[:test_time_limit].to_f

			if params[:test_tags]
				@entry_tags = params[:test_tags].split(",")
				@entry_tags.map! { |tag| tag = tag.strip }
			end
			if !@entry_tags
				@entry_tags = []
			end

			if params[:test_private]
				@entry_private = true
			else
				@entry_private = false
			end

			@test.update(owner: @entry_owner, name: @entry_name, description: @entry_description, questions: @entry_questions, time_limit: @entry_time_limit, tags: @entry_tags, private: @entry_private)
			redirect_to(notebook_path(params[:notebook_id]))
		rescue => ex
			# 404 Error if notebook_id is not a registered notebook
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end

	def destroy
		# Test Deletion from the Database
		if !user_signed_in?
			# Only signed in users can attempt this
			redirect_to(new_user_session_path)
		end

		begin
			@notebook = Notebook.find(params[:notebook_id])
			@test = Test.find(params[:test_id])
			@owner = current_user
			if @owner.id == @notebook.owner and @test.notebook == @notebook.id.to_s
				@test.delete
				@notebook.tests.delete(@test.id)
				@notebook.update(tests: @notebook.tests)
				
				redirect_to(notebook_path(params[:notebook_id]))
			else
				# 401 Error if user is not allowed to view the notebook or if the test does not belong to the notebook
				render :file => "#{Rails.root}/public/401", :status => :unauthorized
			end
		rescue => ex
			# 404 Error if notebook_id or test_id is not a registered notebook or test
			render :file => "#{Rails.root}/public/404", :status => :not_found
		end
	end
end
