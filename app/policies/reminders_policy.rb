class RemindersPolicy < ApplicationPolicy
  def index?
    user.present? && user.business?
  end

  def create?
    index?
  end

  def new?
    index?
  end

  def edit?
    user.id  == record.user.id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
