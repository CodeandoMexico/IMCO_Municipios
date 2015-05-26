class UserRequirementPolicy < ApplicationPolicy
  def update?
    user.id == record.user_id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
