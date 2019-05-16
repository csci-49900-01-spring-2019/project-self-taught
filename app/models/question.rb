class Question
  include Mongoid::Document
  
  include NoteEntryHelper

  field :owner,        type: User
  field :notebook,     type: Notebook
  field :private,      type: Boolean,  default: true
  
  field :tags,         type: Array,    default: []

  field :content,      type: String,   default: ""
  field :answer,       type: String,   default: ""
  
  field :ratings,      type: Array,    default: []
  field :comments,     type: Array,    default: []
  field :date_created, type: DateTime, default: DateTime.now

  validates :date_created, presence: true

  def user_auth? user_id, notebook_id
    user_id == owner and notebook_id == notebook
  end

  def can_view? user_id, notebook_id
    notebook_id == notebook and (user_id == owner or private == false)
  end

  def search_match? search_input
    content.match?(/#{search_input}/i) or answer.match?(/#{search_input}/i) or tags.any?{ |tag| tag.match?(/#{search_input}/i) }
  end

  def update_question(user_id, notebook_id, question_content, question_answer, question_tags, question_private)
    entry_owner = user_id
    entry_notebook = notebook_id
    entry_content = question_content
    entry_answer = question_answer
    entry_tags = text2tags(question_tags)
    entry_private = (!question_private or question_private != "false" ? true : false)
    update(owner: entry_owner, notebook: entry_notebook, content: entry_content, answer: entry_answer, tags: entry_tags, private: entry_private)
    self
  end

  def delete_question
    delete()
    begin
      question_notebook = Notebook.find(notebook)
      question_notebook.question_ids().delete(id)
      question_notebook.update(questions: question_notebook.question_ids())
    rescue => ex
    end
    self
  end
end
