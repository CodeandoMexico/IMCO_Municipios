class Municipio < ActiveRecord::Base
  has_many :dependencies
  has_many :ilines
  has_many :users
  has_many :formation_steps



end
