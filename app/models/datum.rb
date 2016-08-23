class Datum

  include Mongoid::Document

  field :id_town, type: String
  field :type, type: String
  field :value, type: String
end
