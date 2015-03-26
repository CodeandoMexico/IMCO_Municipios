class ComplaintsController < ApplicationController
  layout 'blanco'
  before_filter :set_municipios
  before_filter :complaint_parms, only: :create, :update

  def new
    @complaint = Complaint.new
  end

  def create
    if Complaint.validate_and_create(@municipio, complaint_params)

    else

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
    params.require(:complaint).permit(:reason, :custom_reason, :description)
  end
end
