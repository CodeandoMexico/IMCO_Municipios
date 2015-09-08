class InspectionsController < ApplicationController
  before_action :set_inspection, only: :show
  before_action :set_cities, only: [:index, :show]
  before_action :set_search_filters, only: :index
  after_filter :save_my_previous_url!

  add_breadcrumb "Inicio", :root_path
  def index
    @cities = City.all
    add_breadcrumb @city.name ,city_path(@city)
    add_breadcrumb "Inspecciones"
  end

  def show
    @cities = City.all
    add_breadcrumb @city.name ,city_path(@city)
    add_breadcrumb "Inspecciones", city_inspections_path(@city)
    add_breadcrumb @inspection.name
  end

  def download_csv_inspections
  respond_to do |format|
    set_cities
    @line = params[:lines]
    @inspection_line = InspectionLine.where(line_id: @line) if @line.present?
    if params[:q].present?
        @inspections = Inspection.search_by_city(@city, params[:q])
    else
        @inspections =  Inspection.by_city(@city)
    end
    format.csv
  end
end


def download_csv_inspections_show
   @cities = City.all
   @line = params[:lines]
   @inspection = Inspection.find(params[:id_inspection])
   @inspection_line = InspectionLine.where(line_id: @line) if @line.present?
end


  private

  def set_inspection
    @inspection = Inspection.find(params[:id])
    @id_inspection = params[:id]
  end

  def inspection_params
    params.require(:inspection).permit(:name, :matter, :duration, :rule, :before, :during, :after, :sanction, :dependency_id)
  end

  def set_cities
    @city = City.find(params[:city_id])
  end

  def set_search_filters
    unless current_business.nil?
      @line = current_business.line_id
    end
    
    if params[:get]
      @line = params[:get][:lines]
      if valida_giro.nil?
      @inspection_line = InspectionLine.where(line_id: @line) if @line.present?
      if params[:q].present?
        @inspections = Inspection.search_by_city(@city, params[:q])
      else
        @inspections =  Inspection.by_city(@city)
      end
    end
    end
  end


  def valida_giro
    if @line.nil? || @line.empty?
      redirect_to city_inspections_path(@city), error:  'Debes seleccionar un giro.' 
     return "OK"
  end
  return nil
end

end
