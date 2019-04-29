class Note
  include Mongoid::Document

  field :name, type: String
  field :size, type: Integer
  field :ratings, type: Array, default: []
  field :comments, type: Array, default: []
  field :tags, type: Array, default: []
  field :date_created, type: DateTime, default: DateTime.now

  field :user, type: User
  field :notebook, type: Notebook

  validates :name, presence: true
  validates :date_created, presence: true
  validates :user, presence: true
  validates :notebook, presence: true
end
