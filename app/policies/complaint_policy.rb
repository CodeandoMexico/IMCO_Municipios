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
end
