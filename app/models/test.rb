class Test
  include Mongoid::Document

  field :owner,        type: User
  field :notebook,     type: Notebook
  field :private,      type: Boolean,  default: true

  field :name,         type: String
  field :description,  type: String,   default: ""
  field :tags,         type: Array,    default: []

  field :questions,    type: Array,    default: []
  field :time_limit,   type: Float,   default: 0
  
  field :ratings,      type: Array,    default: []
  field :comments,     type: Array,    default: []
  field :date_created, type: DateTime, default: DateTime.now

  def question_array
    if questions
      Question.find(questions)
    else
      []
    end
  end

  validates :owner, presence: true
  validates :notebook, presence: true

  validates :name, presence: true
  validates :date_created, presence: true

  def can_view? user_id, notebook_id
    notebook_id.to_s == notebook and (user_id == owner or private == false)
  end

  def search_match? search_input
    name.match?(/#{search_input}/i) or description.match?(/#{search_input}/i) or tags.any?{ |tag| tag.match?(/#{search_input}/i) }
  end
end
