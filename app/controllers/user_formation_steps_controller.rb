class UserFormationStepsController < ApplicationController
  before_action :authenticate_user!

  # this method is only called with javascript
  # via a post request, so let's respond with jsong
  def update
    @user_formation_step = UserFormationStep.find_or_initialize_by(user_formation_step_params)
    if @user_formation_step.save(user_formation_step_params)
      render status: 201, json: @user_formation_step
    else
      render status: 400,  json: @user_formation_step
    end
  end

  private

  def user_formation_step_params
    params.require(:user_formation_step).permit(
      :user_id,
      :formation_step_id,
      :line_id,
      :type_user_formation_step
    )
  end
end
