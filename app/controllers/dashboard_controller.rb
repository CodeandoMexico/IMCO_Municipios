class DashboardController < ApplicationController
  before_action :verify_admin
  layout 'dashboard'

  def show
  @denuncias = policy_scope(Complaint).where(municipio_id: current_user.municipio).last
  end

end