class UserProceduresController < ApplicationController
  before_action :authenticate_user!

  def update
    @user_procedure = UserProcedure.find_or_initialize_by(user_procedure_params)

    if params[:done] && @user_procedure.save(user_procedure_params)
      # let's check that the value of the checkbox is true
      render status: 201, json: @user_procedure
    elsif !params[:done] && @user_procedure.persisted?
      # if it's not true but a record is present we have to delete it
      @user_procedure.destroy
      render status: 200, json: @user_procedure
    else
      # there has been an unexpected error or information is invalid
      render status: 400,  json: @user_procedure
    end
  end

  private

  def user_procedure_params
    params.require(:user_procedure).permit(:user_id, :procedure_id)
  end
end
