class UserFormationStepsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: :index

  # this method is only called with javascript
  # via a post request, so let's respond with jsong
  def update
    @user_formation_step = UserFormationStep.find_or_initialize_by(user_formation_step_params)
    authorize @user_formation_step

    if params[:done] && @user_formation_step.save(user_formation_step_params)
      # let's check that the value of the checkbox is true
      render status: 201, json: @user_formation_step
    elsif !params[:done] && @user_formation_step.persisted?
      # if it's not true but a record is present we have to delete it
      @user_formation_step.destroy
      render status: 200, json: @user_formation_step
    else
      # there has been an unexpected error or information is invalid
      render status: 400,  json: @user_formation_step
    end
  end

  private

  def user_formation_step_params
    params.require(:user_formation_step).permit(
      :business_id,
      :formation_step_id,
      :line_id,
      :type_user_formation_step
    )
  end
end
