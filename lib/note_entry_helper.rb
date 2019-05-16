module NoteEntryHelper
	def text2tags(tags)
		if tags
			tag_array = tags.split(",")
			tag_array.map! { |tag| tag = tag.strip }
		end
		if !tag_array
			tag_array = []
		end

		tag_array
	end
end