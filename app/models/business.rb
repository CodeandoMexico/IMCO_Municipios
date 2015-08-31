class Business < ActiveRecord::Base

  validates_presence_of :business_name, :message => 'Debes escribir el nombre de tu negocio.', if: :business?, on:  :update
  validates_length_of :business_name, :minimum => 3, :message => 'El nombre debe tener por lo menos 3 caracteres.', if: :business?, on:  :update

  validates_presence_of :address, :message => 'Debes escribir la dirección de tu negocio (puede ser solo la colonia).', if: :business?, on:  :update
  validates_length_of :address, :minimum => 10, :message => 'la dirección debe tener por lo menos 10 caracteres.', if: :business?, on:  :update

  validates_presence_of :operation_license, :message => "La licencia de operación no puede estar en blanco.", if: :business?, on:  :update
  validates_format_of :operation_license, :with => /\A[a-zA-Z-0-9]+\z/, :message => "La licencia de operación solo debe tener letras, número y guiones.", if: :business?, on:  :update

  validates_presence_of :city_id, :message => 'Debes escribir el municipio donde está tu negocio.', on:  :update
  validates_presence_of :line_id, :message => 'Debes escribir el giro de tu negocio.', if: :business?, on:  :update

  belongs_to :user

  validates :city_id, presence: true
  belongs_to :city

  belongs_to :line
  has_many :user_formation_step
  has_many :formation_steps, through: :user_formation_step
  has_many :user_procedures
  has_many :procedures, through: :user_procedures
  has_many :user_requirements
  has_many :requirements, through: :user_requirements

  mount_uploader :operation_license_file, PdfUploader
  mount_uploader :land_permission_file, PdfUploader



  def business?
    
  end

end
