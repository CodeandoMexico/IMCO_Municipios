class InspectionPolicy < ApplicationPolicy
  def create?
    record.dependency.municipio_id == user.municipio_id && user.admin?
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
          where(dependencies: { municipio_id: user.municipio_id })
      else
        scope
      end
    end
  end
end
