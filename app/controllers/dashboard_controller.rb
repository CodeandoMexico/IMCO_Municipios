class DashboardController < ApplicationController
  before_action :verify_admin
  layout 'dashboard'

  def show
  @complaint = {panel: 'panel-primary', awesome_icons_class: 'fa fa-comments fa-5x', 
    value: Complaint.where(city_id: current_user.city_id).count, message: 'Denuncias!', path: root_path}

  @business_creates = {panel: 'panel-primary', awesome_icons_class: 'fa fa-comments fa-5x',
   value: User.where(admin: false).count, message: 'Empresarios!', path: root_path}

  @business_this_week = {panel: 'panel-primary', awesome_icons_class: 'fa fa-comments fa-5x', 
    value: Complaint.count, message: 'Denuncias!', path: root_path}

  @users_with_reminders = {panel: 'panel-primary', awesome_icons_class: 'fa fa-comments fa-5x', 
    value: Complaint.count, message: 'Denuncias!', path: root_path}

  @new_reminders = {panel: 'panel-primary', awesome_icons_class: 'fa fa-comments fa-5x', 
    value: Complaint.count, message: 'Denuncias!', path: root_path}

  @documents_until_to = {panel: 'panel-primary', awesome_icons_class: 'fa fa-comments fa-5x', 
    value: Complaint.count, message: 'Denuncias!', path: root_path}
      
  @kpis = [@complaint, @business_creates, @business_this_week, @users_with_reminders,@new_reminders,@documents_until_to]
  end

end
