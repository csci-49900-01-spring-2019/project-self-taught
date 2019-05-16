class TestSession
  include Mongoid::Document

  field :owner,        type: User
  field :test,         type: Test

  field :answers,      type: Array, default: []
  field :questions,    type: Array, default: []
  field :time_limit,   type: Float, default: 0.0

  field :date_created, type: DateTime, default: DateTime.now

  validates :date_created, presence: true

  def user_auth? user_id, notebook_id, test_model
    user_id.to_s == owner.to_s and test_model.id.to_s == test.to_s and test_model.user_auth?(user_id, notebook_id)
  end
end
