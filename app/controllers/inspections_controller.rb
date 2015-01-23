class InspectionsController < ApplicationController
  before_action :set_inspection, only: :show
  before_action :set_municipio, only: [:index, :show]
  layout 'blanco'

  def index
    if params[:q]
      @inspections = Inspection.search_by_city(@municipio, params[:q])
    else
      @inspections = Inspection.by_city(@municipio)
    end
  end

  def show
  end

  private
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    def inspection_params
      params.require(:inspection).permit(:nombre, :materia, :duracion, :norma, :antes, :durante, :despues, :sancion, :dependency_id)
    end

    def set_municipio
       @municipio = Municipio.find(params[:municipio_id])
    end


  

end
