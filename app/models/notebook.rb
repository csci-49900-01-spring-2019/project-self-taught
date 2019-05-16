class Notebook
  include Mongoid::Document

  include NoteEntryHelper

  field :owner,        type: User
  field :private,      type: Boolean,  default: true

  field :name,         type: String
  field :description,  type: String,   default: ""
  field :tags,         type: Array,    default: []

  field :notes,        type: Array,    default: []
  field :questions,    type: Array,    default: []
  field :tests,        type: Array,    default: []

  field :ratings,      type: Array,    default: []
  field :comments,     type: Array,    default: []
  field :date_created, type: DateTime, default: DateTime.now

  validates :name, presence: true
  validates :date_created, presence: true

  def user_auth? user_id
    user_id == owner
  end

  def can_view? user_id
    user_auth?(user_id) or private == false
  end

  def can_create_note? user_id
    user_auth? user_id
  end

  def can_create_question? user_id
    user_auth? user_id
  end

  def search_match? search_input
    name.match?(/#{search_input}/i) or description.match?(/#{search_input}/i) or tags.any?{ |tag| tag.match?(/#{search_input}/i) }
  end

  def note_ids
    if !notes
      update(notes: [])
    end
    notes
  end

  def question_ids
    if !questions
      update(questions: [])
    end
    questions
  end

  def test_ids
    if !tests
      update(tests: [])
    end
    tests
  end

  def note_models user_id=nil
    note_mdls = Note.where(owner: owner, notebook: id) 
    if note_mdls and user_id and !user_auth?(user_id)
      note_mdls.where(private: false)
    else
      note_mdls
    end
  end

  def question_models user_id=nil
    question_mdls = Question.where(owner: owner, notebook: id) 
    if question_mdls and user_id and !user_auth?(user_id)
      question_mdls.where(private: false)
    else
      question_mdls
    end
  end

  def test_models user_id=nil
    test_mdls = Test.where(owner: owner, notebook: id) 
    if test_mdls and user_id and !user_auth?(user_id)
      test_mdls.where(private: false)
    else
      test_mdls
    end
  end
  
  def update_notebook(user_id, notebook_name, notebook_description, notebook_tags, notebook_private)
    entry_owner = user_id
    entry_name = notebook_name
    entry_description = notebook_description
    entry_tags = text2tags(notebook_tags)
    entry_private = (!notebook_private or notebook_private != "false" ? true : false)
    update(owner: entry_owner, name: entry_name, description: entry_description, tags: entry_tags, private: entry_private)
    self
  end

  def delete_notebook
    delete()
    begin
      note_models = Note.where(:id.in => notes)
      if note_models
        note_models.each do |note|
          note.delete_note()
        end
      end

      question_models = Question.where(:id.in => questions)
      if question_models
        question_models.each do |question|
          question.delete_question()
        end
      end

      notebook_owner = User.find(owner)
      notebook_owner.notebook_ids().delete(id)
      notebook_owner.update(notebooks: notebook_owner.notebook_ids())
    rescue => ex
    end
    self
  end

  def create_note(note_name, note_description, note_tags, note_private)
    entry_owner = owner
    entry_notebook = id
    entry_name = note_name
    entry_description = note_description
    entry_tags = text2tags(note_tags)
    entry_private = (!note_private or note_private != "false" ? true : false)
    note = Note.create(owner: entry_owner, notebook: entry_notebook, name: entry_name, description: entry_description, tags: entry_tags, private: entry_private)
    update(notes: note_ids().push(note.id))
    note
  end

  def create_question(question_content, question_answer, question_tags, question_private)
    entry_owner = owner
    entry_notebook = id
    entry_content = question_content
    entry_answer = question_answer
    entry_tags = text2tags(question_tags)
    entry_private = (!question_private or question_private != "false" ? true : false)
    question = Question.create(owner: entry_owner, notebook: entry_notebook, content: entry_content, answer: entry_answer, tags: entry_tags, private: entry_private)
    update(questions: question_ids().push(question.id))
    question
  end

  def create_test(test_name, test_description, test_questions, test_time_limit, test_tags, test_private)
    entry_owner = owner
    entry_notebook = id
    entry_name = test_name
    entry_description = test_description
    entry_questions = test_questions
    entry_time_limit = test_time_limit.to_f
    entry_tags = text2tags(test_tags)
    entry_private = (!test_private or test_private != "false" ? true : false)
    test = Test.create(owner: entry_owner, notebook: entry_notebook, name: entry_name, description: entry_description, questions: entry_questions, time_limit: entry_time_limit, tags: entry_tags, private: entry_private)
    update(tests: test_ids().push(test.id))
    test
  end
end
