class Line < ActiveRecord::Base

  has_many :procedure_lines
  has_many :procedures, through: :procedure_lines

  has_many :inspection_lines
  has_many :inspections, through: :inspection_lines

 belongs_to :city



 def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["name", "description","city_id"]#column_names
      all.each do |product|
        csv << [product.name,product.description, City.find(product.city_id).name] 
      end
    end
  end

end
