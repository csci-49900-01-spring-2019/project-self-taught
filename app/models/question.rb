class Question
  include Mongoid::Document
  
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
end
