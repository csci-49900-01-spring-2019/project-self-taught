class Question
  include Mongoid::Document
  field :content, type: String
  field :answer, type: String
end
