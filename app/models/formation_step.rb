class FormationStep < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :city

  has_many :user_formation_step
  has_many :business, through: :user_formation_step

  scope :by_city, -> (city) { where(city: city) }


  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["mane", "description","path","type_formation_step","city_id"]#column_names
      all.each do |product|
        csv << [product.name,product.description, product.path, product.type_formation_step == 'AF' ? 'Física' : 'Moral' , product.city.name]
      end
    end
  end
end
