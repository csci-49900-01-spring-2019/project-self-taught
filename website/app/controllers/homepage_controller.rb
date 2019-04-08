class HomepageController < ApplicationController
	def index
		@navbars = Navbar::FULL_TOP | Navbar::FOOTER
	end
end