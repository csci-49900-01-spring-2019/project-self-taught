class Question
  include Mongoid::Document
  
  include NoteEntryHelper

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

  def user_auth? user_id, notebook_id
    user_id == owner and notebook_id == notebook
  end

  def can_view? user_id, notebook_id
    notebook_id == notebook and (user_id == owner or private == false)
  end

  def search_match? search_input
    content.match?(/#{search_input}/i) or answer.match?(/#{search_input}/i) or tags.any?{ |tag| tag.match?(/#{search_input}/i) }
  end
end
