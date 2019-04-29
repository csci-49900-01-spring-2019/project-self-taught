class PublicNote
  include Mongoid::Document
  field :note, type: Note
end
