class UsersController < ApplicationController
	before_action :setup_negative_captcha, :only => [:new, :create]
	
	private
  def setup_negative_captcha
    @captcha = NegativeCaptcha.new(
      # A secret key entered in environment.rb. 'rake secret' will give you a good one.
      secret: 'd80f158feedeef152f7422448e123600dd2caf58d50e5e66defafcfceac010c213fca30e2b7d4131e0dfbb963dae7b6a6990db83044edd8a14ffed059b8a4800',
      spinner: request.remote_ip,
      # Whatever fields are in your form
      fields: [:name, :email, :body],
      # If you wish to override the default CSS styles (position: absolute; left: -2000px;) used to position the fields off-screen
      css: "display: none",
      params: params
    )
  end

	def new
		@navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
		
		# Decrypted params are stored in @captcha.values
		@comment = Comment.new(@captcha.values)

		# @captcha.valid? will return false if a bot submitted the form
		if @captcha.valid? && @comment.save
			redirect_to @comment
		else
			# @captcha.error will explain what went wrong
			flash[:notice] = @captcha.error if @captcha.error
			render :action => 'new'
		end
	end

	def access
		@navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
	end

	def recover
		@navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
	end

	def reset_password
		@navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
	end

	def signup_complete
		@navbars = Navbar::SITE_FOOTER | Navbar::INFO_NAV_TOP
	end
end