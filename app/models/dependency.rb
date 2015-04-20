class Dependency < ActiveRecord::Base
  belongs_to :city

  has_many :procedures
  has_many :inspectors
  has_many :inspections

  scope :by_city, -> (city) { where(city: city) }



  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["name", "city_id"]#column_names
      all.each do |product|
        csv << [product.name,product.city.name] 
      end
    end
  end
end
