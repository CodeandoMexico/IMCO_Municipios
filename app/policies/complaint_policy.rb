class ComplaintPolicy < ApplicationPolicy
  def index?
    user.present? && user.admin?
  end

  def create?
    user.present? && user.business?
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def edit?
    update?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.where(city_id: user.city_id)
      else
        scope
      end
    end
  end
end
