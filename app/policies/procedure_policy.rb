class ProcedurePolicy < ApplicationPolicy
  def create?
    #raise record.inspect
    record.dependency.city_id == user.city_id && user.admin?
  end

  # def new?
  #   create?
  # end

  def update?
    create?
  end

  # def edit?
  #   update?
  # end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.
          includes(:dependency).
          where(dependencies: { city_id: user.city_id })
      else
        scope
      end
    end
  end
end
