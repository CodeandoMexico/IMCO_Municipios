class Procedure < ActiveRecord::Base
  belongs_to :dependency

  has_many :procedure_requirements
  has_many :requirements, through: :procedure_requirements

  has_many :procedure_lines
  has_many :lines, through: :procedure_lines

  def to_s
    self.name
  end


  scope :by_city,
    -> (city) {
      includes(:dependency).
      where(dependencies: { city_id: city.id })
    }

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["name","long","cost", "validity","contact","dependencia_id","type_procedure","giros","tramites"]#column_names
      all.each do |product|
        csv << [product.name, product.long, product.cost,product.validity, product.contact, Dependency.find(product.dependency_id).nombre,
          tipo_tramite(product.type_procedure),  procedure_lines(product.id), procedure_requirements(product.id)]
        end
      end
    end
  end




  def procedure_lines(id_procedure)
    aux = []
    ProcedureLine.where(procedure_id: id_procedure).each_with_index do |line, index|
      aux[index] = Line.find(line.line_id).name
    end
    if aux.blank?
      'N/A'
    else
      aux.map(&:inspect).join('; ').gsub /"/, ''
    end
  end


def procedure_requirements(id_procedure)
  aux = []
  ProcedureRequirement.where(procedure_id: id_procedure).each_with_index do |requirement, index|
    aux[index] = Requirement.find(requirement.requirement_id).name
  end
  if aux.blank?
    'N/A'
  else
    aux.map(&:inspect).join('; ').gsub /"/, ''
  end
end

def tipo_tramite(tramite)
   if tramite == 'TF'
    'Física'
  elsif  tramite == 'TM'
    'Moral'
  else
    'Ambas'
  end
end
