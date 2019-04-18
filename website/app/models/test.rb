class Test
  include Mongoid::Document
  field :name, type: String
  field :questions, type: Array
  field :time_limit, type: DateTime
  field :user, type: User
  field :tags, type: Array
end
