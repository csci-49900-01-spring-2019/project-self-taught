class Note
  include Mongoid::Document
  field :name, type: String
  field :creator, type: User
  field :tags, type: Array
  field :date_created, type: DateTime
  field :size, type: Integer
  field :ratings, type: Array
  field :comments, type: Array
end
