module Dashboard
  class ReportsController < Dashboard::BaseController
    before_action :set_report, only: [:edit, :update, :destroy, :show]
    layout 'dashboard'

    def index
      @complaints = policy_scope(Complaint).order(:created_at)#.where(user_id: current_user).order(:created_at)
    end

    def show

    end


    private
    def set_report
      @report = Complaint.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:name, :city_id)
    end
  end
end
