class TestsController < ApplicationController
	include TestsHelper
	def show
	end

	def user
	end

	def new
		if user_signed_in?
			@test = Test.new
			render :new
		else
			redirect_to('/users/sign_in')
		end
	end

	def create
		if user_signed_in?
			@user = User.where(username: current_user[:username]).first
			@notebook = Notebook.find(params[:notebook_id])
			@questions = make_questions_from_params(params)
			@notebook.test_create(test_params, @user.id, @notebook.id, @questions)
			redirect_to(notebook_path(params[:notebook_id]))
		else
			redirect_to('/users/sign_in')
		end
	end

	def edit #GET for test editing
		if user_signed_in?
			@user = User.where(username: current_user[:username]).first
			@notebook = Notebook.find(params[:notebook_id])
			@test = Test.find(params[:id])
			if @user.notebook_owner?(@notebook.id) && @notebook.test_owner?(@test.id)
			else
			end
		else
			redirect_to('/users/sign_in')
		end
	end

	def update #PUT & PATCH for saving test edits
		if user_signed_in?
			@user = User.where(username: current_user[:username]).first
			@notebook = Notebook.find(params[:notebook_id])
			@test = Test.find(params[:id])
			@questions = make_questions_from_params(params)
			if @user.notebook_owner?(@notebook.id) && @notebook.test_owner?(@test.id)
				@test.update(test_params.merge!(questions: @questions))
				redirect_to(notebook_path(params[:notebook_id]))
			end
		else
			redirect_to('/users/sign_in')
		end
	end

	def destroy #DELETE for a test deletion
		if user_signed_in?
			@notebook = Notebook.find(params[:notebook_id])
			@notebook.test_delete(params[:id])
		else
		end
	end

	def test_params
		params.require(:test).permit(:name)
	end	
end
