class Comment
  include Mongoid::Document
  field :user, type: User
  field :comment, type: String
end
