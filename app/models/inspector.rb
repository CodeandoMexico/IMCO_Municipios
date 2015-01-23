class Inspector < ActiveRecord::Base
  belongs_to :dependency

  scope :by_city,
    -> (city) {
      includes(:dependency).
      where(dependencies: { municipio_id: city.id })
    }

  scope :search_by_city,
    -> (city, query) {
       by_city(city).
       where("inspectors.nombre ILIKE ?", "%#{query}%")
     }
end
