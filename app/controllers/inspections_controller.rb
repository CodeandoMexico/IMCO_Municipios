class InspectionsController < ApplicationController
  before_action :set_inspection, only: :show
  before_action :set_municipio, only: [:index, :show]
  after_filter :save_my_previous_url!
  layout 'blanco'

  def index
     valores  if params[:get]
         @municipios = Municipio.all
 end
 
  def valores
     @line = params[:get][:lines]
     @first_time = true
     if params[:q]
      @inspections = Inspection.search_by_city(@municipio, params[:q])
      @inspection_line = InspectionLine.where(line_id: @line)
    else
        @inspections =  Inspection.by_city(@municipio)
         @inspection_line = InspectionLine.where(line_id: @line)
      end
 end 

  def show
        @municipios = Municipio.all
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
