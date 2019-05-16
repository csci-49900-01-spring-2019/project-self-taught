class Test
  include Mongoid::Document

  include NoteEntryHelper

  field :owner,        type: User
  field :notebook,     type: Notebook
  field :session,      type: TestSession
  field :private,      type: Boolean,     default: true

  field :name,         type: String
  field :description,  type: String,      default: ""
  field :tags,         type: Array,       default: []

  field :questions,    type: Array,       default: []
  field :time_limit,   type: Float,       default: 0.0
  
  field :ratings,      type: Array,       default: []
  field :comments,     type: Array,       default: []
  field :date_created, type: DateTime,    default: DateTime.now

  validates :owner, presence: true
  validates :notebook, presence: true

  validates :name, presence: true
  validates :date_created, presence: true

  def user_auth? user_id, notebook_id
    user_id == owner and notebook_id == notebook
  end

  def can_view? user_id, notebook_id
    notebook_id == notebook and (user_id == owner or private == false)
  end

  def search_match? search_input
    name.match?(/#{search_input}/i) or description.match?(/#{search_input}/i) or tags.any?{ |tag| tag.match?(/#{search_input}/i) }
  end

  def new_session user_id
    if session
      begin
        TestSession.find(session).delete()
      rescue => ex
        
      end
    end
    session = TestSession.create(owner: user_id, test: id, questions: questions.shuffle, time_limit: time_limit).id
    update(session: session)
  end
end
