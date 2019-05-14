class TestSession
  include Mongoid::Document

  field :name, type: String
  field :answers, type: Array, default: []
  field :questions, type: Array, default: []
  field :time_limit, type: DateTime
end
