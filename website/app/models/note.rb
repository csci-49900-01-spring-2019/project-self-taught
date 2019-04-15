class Note
  include Mongoid::Document
	
  field :name,          type: String, default: ""
	field :creator,				type: User
	field :tags,					type: Array
	field :created_at,    type: DateTime
	field :size,					type: Integer
	field :ratings,				type: Array
	field :comments,			type: Array
end
