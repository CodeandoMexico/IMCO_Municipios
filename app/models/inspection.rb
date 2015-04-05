class Inspection < ActiveRecord::Base
  belongs_to :dependency

  has_many :inspection_lines
  has_many :lines, through: :inspection_lines
  has_many :inspection_requirements
  has_many :requirements, through: :inspection_requirements

  scope :by_city,
    -> (city) {
      includes(:dependency).
      where(dependencies: { city_id: city.id })
    }

  scope :search_by_city,
    -> (city, query) {
      by_city(city).
      where("inspections.name ILIKE ?", "%#{query}%")
    }


def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["name","matter","duration", "rule","before","during","after","sanction","dependencia_id","lines","requirements"]#column_names
      all.each do |product|
        csv << [
          product.name,
          product.matter,
          product.duration,
          product.rule,
          product.before,
          product.during,
          product.after,
          product.sanction,
          Dependency.find(product.dependency_id).name,
          inspection_lines(product.id),
          inspection_requirements(product.id)] 
        end
      end
    end
  end



  def inspection_lines(id_inspection)
    aux = []
    InspectionLine.where(inspection_id: id_inspection).each_with_index do |line, index|
      aux[index] = Line.find(line.line_id).name
    end
    if aux.blank?
      'N/A' 
    else
      aux.map(&:inspect).join('; ').gsub /"/, ''
    end
  end


def inspection_requirements(id_inspection)
  aux = []
  InspectionRequirement.where(inspection_id: id_inspection).each_with_index do |requirement, index|
    aux[index] = Requirement.find(requirement.requirement_id).name
  end
  if aux.blank?
    'N/A' 
  else
    aux.map(&:inspect).join('; ').gsub /"/, ''
  end
end


