class NotebooksController < ApplicationController
	def user
		@notebook = Notebook.create(name: "My notebook")

		@userlogin = true
		@navbars = Navbar::FULL_TOP | Navbar::FOOTER
	end
end