class ReportPolicy < ApplicationPolicy
  def create?
   #raise record.inspect
    record.city_id == user.city_id && user.admin?
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
      scope
    end
  end
end
