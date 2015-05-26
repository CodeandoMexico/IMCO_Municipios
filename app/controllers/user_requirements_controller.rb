class UserRequirementsController < ApplicationController
  before_action :authenticate_user!

  def update
    @user_requirement = UserRequirement.find_or_initialize_by(user_requirements_params)

    if params[:done] && @user_requirement.save(user_requirements_params)
      # let's check that the value of the checkbox is true
      render status: 201, json: @user_requirement
    elsif !params[:done] && @user_requirement.persisted?
      # if it's not true but a record is present we have to delete it
      @user_requirement.destroy
      render status: 200, json: @user_requirement
    else
      # there has been an unexpected error or information is invalid
      render status: 400,  json: @user_requirement
    end
  end

  private

  def user_requirements_params
    params.require(:user_requirement).permit(:user_id, :requirement_id)
  end
end
