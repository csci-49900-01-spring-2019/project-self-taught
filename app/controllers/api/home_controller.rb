module Api
	class HomeController < Api::ApiBaseController
		def index
			redirect_to api_v1_root_path
		end
	end
end