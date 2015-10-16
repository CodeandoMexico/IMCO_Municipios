class City < ActiveRecord::Base
  has_many :dependencies
  has_many :lines
  has_many :users
  has_many :formation_steps
  has_many :requirements
  has_many :complaints

  mount_uploader :privacy_file, PdfUploader
  mount_uploader :construction_file, PdfUploader
  mount_uploader :land_file, PdfUploader
  mount_uploader :business_file, PdfUploader


  mount_uploader :dependency_file, CsvUploader
  mount_uploader :line_file, CsvUploader
  mount_uploader :formation_step_file, CsvUploader
  mount_uploader :requirement_file, CsvUploader
  mount_uploader :procedure_file, CsvUploader
  mount_uploader :inspection_file, CsvUploader
  mount_uploader :inspector_file, CsvUploader


  scope :is_activated, -> { where(activated: true) }
end
