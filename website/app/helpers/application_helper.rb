module ApplicationHelper
	def draw_notebook(client_type, name, desc="")
		notebook_html = ''
		closing_tags = ''

		# Container
		# if ApplicationController::ViewType::DESKTOP == client_type
		# 	notebook_html += '<div class="notebook-container shadow-sm mx-3 my-3">'
		# 	closing_tags = '</div>' + closing_tags
		# else
		# 	notebook_html = ''
		# end

		notebook_html = '
			<div class="notebook-container shadow-sm mx-3 my-3">
				<div class="d-flex justify-content-start flex-row w-100 h-100">
					<div class="bg-primary h-100" style="width:32px; min-width:32px; border-radius: 5px 0px 0px 5px;">
						<div class="notebook-menu-top"></div>
						<a href="#"><div class="notebook-button my-1"><center><i class="material-icons">edit</i></center></div></a>
						<a href="#"><div class="notebook-button my-1"><center><i class="material-icons">delete</i></center></div></a>
					</div>
					<div class="flex-fill" style="border-radius: 0px 5px 5px 0px;">
						<div class="notebook-menu-top" style="height: 32px;"><center>' + name + '</center></div>
						<div class="d-flex justify-content-center flex-column w-100" style="height:224px;">
							<p class="text-center">' + desc + '</p>
						</div>
					</div>
				</div>
			</div>'
		notebook_html.html_safe
	end
end
