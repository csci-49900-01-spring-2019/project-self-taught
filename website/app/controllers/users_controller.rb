class UsersController < ApplicationController
	def signup
		@navbars = Navbar::FULL_TOP | Navbar::FOOTER
	end

	def complete_signup
		@navbars = Navbar::FULL_TOP | Navbar::FOOTER
	end

	def login
		@navbars = Navbar::FULL_TOP | Navbar::FOOTER
	end

	def recover
		@navbars = Navbar::FULL_TOP | Navbar::FOOTER
	end

	def reset_password
		@navbars = Navbar::FULL_TOP | Navbar::FOOTER
	end
end