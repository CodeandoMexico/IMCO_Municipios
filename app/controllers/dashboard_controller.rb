class DashboardController < ApplicationController
  before_action :verify_admin
  layout 'dashboard'

  def show
  end
end
