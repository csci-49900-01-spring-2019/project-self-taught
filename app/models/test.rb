class Test
  include Mongoid::Document

  field :owner,        type: User
  field :notebook,     type: Notebook
  field :private,      type: Boolean,  default: true

  field :name,         type: String
  field :description,  type: String,   default: ""
  field :tags,         type: Array,    default: []

  field :questions,    type: Array,    default: []
  field :time_limit,   type: String,   default: DateTime.now
  
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

  validates :name, presence: true
  validates :date_created, presence: true
  validates :user, presence: true
  validates :notebook, presence: true
end
