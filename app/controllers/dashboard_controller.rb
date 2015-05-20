class DashboardController < ApplicationController
  before_action :verify_admin
  layout 'dashboard'

  def show
    users = User.where(admin: false, city_id: current_user.city_id)
    reminders = Reminders.where(user_id: users)
    total_reminders = reminders.joins(:user).where(user_id: users)
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
        value: @complaints.count,
        message: 'Denuncias totales'
      },
      {
        value: users.count,
        message: 'Empresarios registrados'
      },
      {
        value: users.where("created_at >= ? ", 1.week.ago.utc).count,
        message: 'Empresarios nuevos'
      },
      {
        value: total_reminders.count,
        message: 'Recordatorios totales'
      },
      {
        value: total_reminders.uniq.pluck(:user_id).count,
        message: 'Usuarios con recordatorios'
      },
      {
        value: total_reminders.where("until_to <= ? ",Date.today() + 30.day).count,
        message: 'Documentos próximos a vencer'
      }
    ]
  end

end
