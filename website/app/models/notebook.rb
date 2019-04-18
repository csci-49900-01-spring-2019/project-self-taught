class Notebook
  include Mongoid::Document
  field :name, type: String
  field :notes, type: Array
end
