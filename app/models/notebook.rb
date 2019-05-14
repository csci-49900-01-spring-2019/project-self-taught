class Notebook
  include Mongoid::Document

  field :owner,        type: User
  field :private,      type: Boolean,  default: true

  field :name,         type: String
  field :description,  type: String,   default: ""
  field :tags,         type: Array,    default: []

  field :notes,        type: Array,    default: []
  field :questions,    type: Array,    default: []
  field :tests,        type: Array,    default: []

  field :ratings,      type: Array,    default: []
  field :comments,     type: Array,    default: []
  field :date_created, type: DateTime, default: DateTime.now

  def note_owner? note_id
    notes && notes.find(note_id)
  end

  def note_array
    if notes
      Note.find(notes)
    else
      []
    end
  end

  def note_create note_params, user_id, notebook_id
    note = Note.create(note_params.merge!(user: user_id, notebook: notebook_id))
    if notes
      update(notes: notes.push(note.id))
    else
      update(notes: [note.id])
    end
  end

  def note_delete note_id
    if notes && notes.find(note_id)
      note = Note.find(note_id)
      if note
        note.delete
      end
      notes.delete(note.id)
      update(notes: notes)
    end
  end

  def test_owner? test_id
    tests && tests.find(test_id)
  end

  def test_array
    if tests
      Test.find(tests)
    else
      []
    end
  end

  def test_create test_params, user_id, notebook_id, questions
    the_test = Test.create!(test_params.merge!(user: user_id, notebook: notebook_id, questions: questions))
    if tests
      update(tests: tests.push(the_test.id))
    else
      update(tests: [the_test.id])
    end
  end

  def test_delete test_id
    if tests && tests.find(test_id)
      the_test = Test.find(test_id)
      if the_test
        the_test.delete
      end
      tests.delete(the_test.id)
      update(tests: tests)
    end
  end

  validates :name, presence: true
  validates :date_created, presence: true
end
