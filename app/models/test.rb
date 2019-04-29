class Test
  include Mongoid::Document

  field :name, type: String
  field :questions, type: Array, default: []
  field :tags, type: Array, default: []
  field :date_created, type: DateTime, default: DateTime.now

  field :user, type: User
  field :notebook, type: Notebook

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
