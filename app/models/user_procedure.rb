class UserProcedure < ActiveRecord::Base
  belongs_to :business
  belongs_to :procedure
end
