class InspectorsController < ApplicationController
  before_action :set_inspector, only: :show
  before_action :set_municipio, only: [:index, :show]
  layout 'blanco'

  def index
    if params[:q]
      @inspectors = Inspector.search(params[:q]).order("created_at DESC")
    else
      @inspectors = Inspector.all
    end
    @dependency = Dependency.all
    cargar_menus
  end

  def show
    cargar_menus

  end

  private
    def set_inspector
      @inspector = Inspector.find(params[:id])
    end

    def inspector_params
      params.require(:inspector).permit(:nombre, :vigencia, :materia, :supervisor, :contacto, :foto, :dependency_id)
    end

    def set_municipio
       @municipio = Municipio.find(params[:municipio_id])
    end



     def cargar_menus
      @link_1 ="/dashboard"
     @texto_link_1 = "Apertura"
      @link_2="/dashboard"
     @texto_link_2 = "Tramites"
      @link_3 =""
     @texto_link_3 = ""
    end
end
