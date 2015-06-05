class City < ActiveRecord::Base
  has_many :dependencies
  has_many :ilines
  has_many :users
  has_many :formation_steps
  has_many :requirements
  has_many :complaints
  mount_uploader :privacy_file, PdfUploader
end
