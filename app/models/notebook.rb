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
      notebook_owner = User.find(owner)
      notebook_owner.notebook_ids().delete(id)
      notebook_owner.update(notebooks: notebook_owner.notebook_ids())
    rescue => ex
    end
    self
  end

  def note_models
    note_mdls = Note.where(:id.in => notes)
    note_mdls ? note_mdls : []
  end

  def question_models
    question_mdls = Question.where(:id.in => questions)
    question_mdls ? question_mdls : []
  end

  def test_models
    test_mdls = Test.where(:id.in => tests)
    test_mdls ? test_mdls : []
  end
end
