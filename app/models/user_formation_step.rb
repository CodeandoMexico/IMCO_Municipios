class UserFormationStep < ActiveRecord::Base
  belongs_to :business
  belongs_to :formation_step
end
