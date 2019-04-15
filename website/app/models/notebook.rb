class Notebook
  include Mongoid::Document

  field :name,          type: String, default: ""
	field :notes,					type: Array
end
