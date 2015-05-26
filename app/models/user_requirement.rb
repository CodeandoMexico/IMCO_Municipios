class UserRequirement < ActiveRecord::Base
  belongs_to :user
  belongs_to :requirement
end
