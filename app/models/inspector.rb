class Inspector < ActiveRecord::Base
  belongs_to :dependency
  mount_uploader :foto, InspectorUploader

  scope :by_city,
    -> (city) {
      includes(:dependency).
      where(dependencies: { city_id: city.id })
    }

  scope :search_by_city,
    -> (city, query) {
       by_city(city).
       where("inspectors.name ILIKE ?", "%#{query}%")
     }



 def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["name","validity","matter", "supervisor","contact","photo","dependencia_id"]#column_names
      all.each do |product|
        csv << [product.name, product.validity, product.matter,product.supervisor, product.contact, product.photo,Dependency.find(product.dependency_id).name]
        end
      end
    end
  end
