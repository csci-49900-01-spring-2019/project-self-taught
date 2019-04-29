class Rating
  include Mongoid::Document
  field :user, type: User
  field :rating, type: Integer
end
