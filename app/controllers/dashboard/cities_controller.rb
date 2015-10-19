module Dashboard
  class CitiesController < ApplicationController
    before_filter :set_city
    layout 'dashboard'

    def update
    end

    def index
    end

    def edit
      @city = City.find(params[:id])
    end

    def new
      @city = City.new
    end



    private

    def set_city
      @cities = City.all
      @user = current_user
    end


    def city_params
      params.require(:city).permit(:name, :contact_email, :privacy_file, :contact_phone,:regulations_path, :construction_file, :land_file, :business_file,
        :dependency_file, :line_file, :formation_step_file, :requirement_file, :procedure_file, :inspection_file, :inspector_file)
    end

  end
end