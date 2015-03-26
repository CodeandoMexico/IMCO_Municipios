class Complaint < ActiveRecord::Base
  belongs_to :municipio
  belongs_to :user
end
