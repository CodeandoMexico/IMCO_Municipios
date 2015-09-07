class UserFormationStepPolicy < ApplicationPolicy
  
  def update?
    user.has_business?(record.business_id)#user.id == record.business_id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
