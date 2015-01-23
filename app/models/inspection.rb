class Inspection < ActiveRecord::Base
  belongs_to :dependency

  has_many :inspection_lines
  has_many :lines, through: :inspection_lines
  has_many :inspection_requirements
  has_many :requirements, through: :inspection_requirements

  scope :by_city,
    -> (city) {
      includes(:dependency).
      where(dependencies: { municipio_id: city.id })
    }

  scope :search_by_city,
    -> (city, query) {
      by_city(city).
      where("inspections.nombre ILIKE ?", "%#{query}%")
    }
end
