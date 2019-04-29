module TestsHelper
	def make_questions_from_params params
		questions = []
		params.keys.each do |param|
			res = /^question([0-9]+)$/.match(param)
			if res
				ques = params[param]
				ans = params["answer#{res[1]}"]
				questions.push(Question.create(content: ques, answer: ans).id)
			end
		end
		questions
	end
	def make_question_entry questions
		html_text = ''
		
		id_num = 0
		questions.each do |question|
			id_num += 1
			id = id_num.to_s
			ques_html = '<label for="test_question'+id+'">Question '+id+':</label> <input value="'+question.content+'" type="text" name="question'+id+'" id="test_question'+id+'">'
			ans_html = '<label for="test_answer'+id+'">Answer:</label> <input value="'+question.answer+'" type="text" name="answer'+id+'" id="test_answer'+id+'">'
			html_text += '<p>'+ques_html+ans_html+'</p>'
		end

		html_text.html_safe
	end
end
