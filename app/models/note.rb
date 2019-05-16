class Note
  include Mongoid::Document

  include NoteEntryHelper

  field :owner,        type: User
  field :notebook,     type: Notebook
  field :private,      type: Boolean,  default: true

  field :name,         type: String
  field :description,  type: String,   default: ""
  field :tags,         type: Array,    default: []

  field :file_size,    type: Integer,  default: 0
  field :file_type,    type: String,   default: nil
  field :file_path,    type: String,   default: nil
  
  field :ratings,      type: Array,    default: []
  field :comments,     type: Array,    default: []
  field :date_created, type: DateTime, default: DateTime.now

  validates :owner,        presence: true
  validates :notebook,     presence: true
  
  validates :name,         presence: true
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

  def update_note(user_id, notebook_id, note_name, note_description, note_tags, note_private)
    entry_owner = user_id
    entry_notebook = notebook_id
    entry_name = note_name
    entry_description = note_description
    entry_tags = text2tags(note_tags)
    entry_private = (!note_private or note_private != "false" ? true : false)
    update(owner: entry_owner, notebook: entry_notebook, name: entry_name, description: entry_description, tags: entry_tags, private: entry_private)
    self
  end

  def delete_note
    delete()
    begin
      note_notebook = Notebook.find(notebook)
      note_notebook.note_ids().delete(id)
      note_notebook.update(notes: note_notebook.note_ids())
    rescue => ex
    end
    self
  end
end
