class LearnsController < ApplicationController
  add_breadcrumb "Inicio", :root_path

  def index
    add_breadcrumb "Aprende" 
    @learns = Learn.order(:category)


    @kpi_data = [
      {
        value: 1,
        message: t('.users_total')
      },
      {
        value: 2,#where("created_at >= ? ", 1.week.ago.utc).count,
        message: t('.business_total')
      },
      {
        value: 3,
        message: t('.business_news')
      },
      {
        value: 4,
        message: t('.complaints_message')
      },
      {
        value: 5,
        message: t('.reminders_total')
      },
      {
        value: 6,
        message: t('.documents_until_to')
      }
    ]
  end
end