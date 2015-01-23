class Dependency < ActiveRecord::Base
  belongs_to :municipio

  has_many :procedures
  has_many :inspectors
  has_many :inspections

  scope :by_city, -> (city) { where(municipio: city) }
end
