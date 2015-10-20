class UserPolicy < ApplicationPolicy
  def create?
   #raise record.inspect
      user.admin? && record.is_super_user
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
end
