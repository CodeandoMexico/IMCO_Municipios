class DashboardController < ApplicationController
  before_action :verify_admin
  layout 'dashboard'

  def show
    business = Business.where(city_id: current_user.city_id) 
    reminders = Reminders.where(business_id: business)
    users = Business.where(city_id: current_user.city_id).pluck(:id).uniq
    @dependencies = policy_scope(Dependency)
    @lines = policy_scope(Line)
    @formation_steps= policy_scope(FormationStep)
    @requirements = policy_scope(Requirement)
    @procedures = policy_scope(Procedure)
    @inspections = policy_scope(Inspection)
    @inspectors = policy_scope(Inspector)
    @complaints = policy_scope(Complaint)

    @kpi_data = [
      {
        value: users.count,
        message: t('.users_total')
      },
      {
        value: business.count,#where("created_at >= ? ", 1.week.ago.utc).count,
        message: t('.business_total')
      },
      {
        value: business.where("created_at >= ? ", 1.week.ago.utc).count,
        message: t('.business_news')
      },
      {
        value: @complaints.count,
        message: t('.complaints_message')
      },
      {
        value: reminders.count,
        message: t('.reminders_total')
      },
      {
        value: reminders.where("until_to <= ? ",Date.today() + 30.day).count,
        message: t('.documents_until_to')
      }
    ]
  end

  def upload
    @city = City.find(current_user.city_id)

    unless $errors.nil? || $warnings.nil? || $success.nil?
      @errors = $errors
      @warnings = $warnings
      @success = $success
    end
  end

end
