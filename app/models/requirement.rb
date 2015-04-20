class Requirement < ActiveRecord::Base

  has_many :procedure_requirements
  has_many :procedures, through: :procedure_requirements

  has_many :inspection_requirements
  has_many :inspections, through: :inspection_requirements

 belongs_to :city

 
       def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["name", "description","path","city_id"]#column_names
      all.each do |product|
        csv << [product.name,product.description, product.path , product.city.name] 
      end
    end
  end
end
