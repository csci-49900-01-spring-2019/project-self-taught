class NotebooksController < ApplicationController
	def user
		@userlogin = true
		@navbars = Navbar::FULL_TOP | Navbar::FOOTER
	end
end