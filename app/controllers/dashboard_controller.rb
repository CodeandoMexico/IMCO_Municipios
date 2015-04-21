class DashboardController < ApplicationController
  before_action :verify_admin
  layout 'new_dashboard'

  def show
  end
end
