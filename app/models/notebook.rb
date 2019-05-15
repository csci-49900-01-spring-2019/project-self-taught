class Notebook
  include Mongoid::Document

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

  def can_view? user_id
    user_id == owner or private == false
  end

  def search_match? search_input
    name.match?(/#{search_input}/i) or description.match?(/#{search_input}/i) or tags.any?{ |tag| tag.match?(/#{search_input}/i) }
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
