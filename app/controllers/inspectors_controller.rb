class InspectorsController < ApplicationController
  before_action :set_inspector, only: :show
  before_action :set_city, only: [:index, :show]

  def index
     @cities = City.all
    if params[:q]
       @busqueda =Inspector.search_by_city(@city, params[:q])
      @busqueda.count
     @inspectors = @busqueda.page(params[:page]).per(6)
     else
     @busqueda =Inspector.by_city(@city)
      @inspectors = @busqueda.page(params[:page]).per(6)
    end
  end

  def show
         @cities = City.all
    @dependency = Dependency.by_city(@city)
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
