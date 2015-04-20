class InspectorsController < ApplicationController
  before_action :set_inspector, only: :show
  before_action :set_city, only: [:index, :show]

  add_breadcrumb "Inicio", :root_path
  def index
   @cities = City.all
   if params[:q]
     @busqueda =Inspector.search_by_city(@city, params[:q])
     @inspectors = @busqueda.page(params[:page]).per(6)
   else
    # @busqueda =Inspector.by_city(@city)
     @inspectors = Inspector.by_city(@city).page(params[:page]).per(6)
   end

   add_breadcrumb @city.name ,city_path(@city)
   add_breadcrumb "Inspectores"
 end

 def show
   @cities = City.all
   @dependency = Dependency.by_city(@city)
   add_breadcrumb @city.name ,city_path(@city)
   add_breadcrumb "Inspectores", city_inspectors_path(@city)
   add_breadcrumb @inspector.name
 end

 private
 def set_inspector
  @inspector = Inspector.find(params[:id])
end

def inspector_params
  params.require(:inspector).permit(:name, :validity, :matter, :supervisor, :contact, :photo, :dependency_id)
end

def set_city
 @city = City.find(params[:city_id])
end
end
