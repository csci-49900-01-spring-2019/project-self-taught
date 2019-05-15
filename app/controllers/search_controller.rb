class SearchController < MainSiteBaseController
	def index
		search_input = params[:search_input]

		@results = []
		if search_input
			Notebook.each do |notebook|
				if notebook.can_view?(current_user.try(:id))
					if notebook.search_match?(search_input)
						@results.push(notebook)
					end

					notebook.note_models.each do |note|
						if note.can_view?(current_user.try(:id), notebook.id)
							if note.search_match?(search_input)
								@results.push(note)
							end
						end
					end

					notebook.question_models.each do |question|
						if question.can_view?(current_user.try(:id), notebook.id)
							if question.search_match?(search_input)
								@results.push(question)
							end
						end
					end

					notebook.test_models.each do |test|
						if test.can_view?(current_user.try(:id), notebook.id)
							if test.search_match?(search_input)
								@results.push(test)
							end
						end
					end
				end
			end

			@results
		else
			@results
		end
	end
end