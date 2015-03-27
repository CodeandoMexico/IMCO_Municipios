class ComplaintsController < ApplicationController
  layout 'blanco'
  before_action :authenticate_business!
  before_action :business_profile_complete!
  before_action :set_municipios
  before_action :complaint_params, only: [:create, :update]

  def new
    @complaint = Complaint.new
    authorize @complaint
  end

  def create
   @complaint = Complaint.new(
                  user: current_user,
                  municipio: @municipio,
                  reason: complaint_params[:reason],
                  custom_reason: complaint_params[:custom_reason],
                  description: complaint_params[:description]
                 )
    authorize @complaint
    if @complaint.save

      #Enviamos correo
       ComplaintMailer.send_to_business(current_user,@complaint).deliver

      redirect_to municipio_inspections_path(@municipio),
        notice: I18n.t('complaints.created_successfully')
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def set_municipios
    @municipio = Municipio.find(params[:municipio_id])
    @municipios = Municipio.all
  end

  def complaint_params
    params.require(:complaint).permit(
      :reason,
      :custom_reason,
      :description
    )
  end
end
