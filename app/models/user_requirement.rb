class UserRequirement < ActiveRecord::Base
  belongs_to :business
  belongs_to :requirement
end
