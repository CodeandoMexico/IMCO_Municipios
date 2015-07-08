class FormationStepsController < ApplicationController
  before_action :set_formation_steps, only: [:show]
  helper :formation_steps

  add_breadcrumb "Inicio", :root_path
  require 'csv'

  def index
    set_city(:city_id)
    @tipo = 'AF'
    valores  if params[:get]
    @cities = City.all
    if user_signed_in?
      @tramites_realizados =  UserFormationStep.where(user_id: current_user.id, line_id: @line , type_user_formation_step: @tipo).all
    end
    add_breadcrumb @city.name ,city_path(@city)
    add_breadcrumb "Nuevo negocio"
  end


  def show
  end

  def valores
    if params[:get][:lines]
     @line = params[:get][:lines]
     get_values
  end
end

def get_values
    @tipo = params[:rating]
     valida_parametros
     @commit = params[:commit]
    if params[:commit] == 'Federales'
      @formation_steps = FormationStep.by_city(@city).where(type_of_procedure: 'Federal')
      @tramite = 'federales'
    elsif params[:commit] == 'Municipales'
      @tramite = 'municipales'
      @procedure_requirements = ProcedureRequirement.all
      @requirements = Requirement.all
      @procedure_lines = ProcedureLine.where(line_id: @line)
    elsif params[:commit] == 'Estatales'
      @formation_steps = FormationStep.by_city(@city).where(type_of_procedure: 'Estatal')
      @tramite = 'estatales'
    end

end

def download_csv
  respond_to do |format|
      @line = params[:lines]
        get_values
        
        format.csv
  end
end

def valida_parametros
    if @line.nil? || @line.empty?
      redirect_to city_formation_steps_path(@city),  error:  "Debes seleccionar un giro."
    end
end


private
      # Use callbacks to share common setup or constraints between actions.
      def set_city(val)
        @city = City.find(params[val])
      end

      def set_formation_steps
        @formation_step = City.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def formation_step_params
        params.require(:formationsteps).permit(:name, :description,:path,:type_formation_step )
      end
    end
