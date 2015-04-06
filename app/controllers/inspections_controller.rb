class InspectionsController < ApplicationController
  before_action :set_inspection, only: :show
  before_action :set_cities, only: [:index, :show]
  after_filter :save_my_previous_url!
  layout 'blanco'

  def index
     valores  if params[:get]
         @cities = City.all
 end
 
  def valores
     @line = params[:get][:lines]
     @first_time = true
     if params[:q]
      @inspections = Inspection.search_by_city(@city, params[:q])
      @inspection_line = InspectionLine.where(line_id: @line)
    else
        @inspections =  Inspection.by_city(@city)
         @inspection_line = InspectionLine.where(line_id: @line)
      end
 end 

  def show
        @cities = City.all
  end

  private
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    def inspection_params
      params.require(:inspection).permit(:name, :matter, :duration, :rule, :before, :during, :after, :sanction, :dependency_id)
    end

    def set_cities
       @city = City.find(params[:city_id])
    end
end
