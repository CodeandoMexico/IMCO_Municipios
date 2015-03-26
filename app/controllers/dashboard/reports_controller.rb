module Dashboard
  class ReportsController < Dashboard::BaseController
    before_action :set_report, only: [:edit, :update, :destroy, :show]
    layout 'dashboard'

    def index
      @reports = policy_scope(Complaint).where(municipio_id: current_user.municipio).order(:created_at)
    end

    def show
          
    end


    private
    def set_report
      @report = Complaint.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:nombre, :municipio_id)
    end
  end
end