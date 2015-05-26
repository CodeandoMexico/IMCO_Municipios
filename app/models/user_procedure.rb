class UserProcedure < ActiveRecord::Base
  belongs_to :user
  belongs_to :procedure
end
