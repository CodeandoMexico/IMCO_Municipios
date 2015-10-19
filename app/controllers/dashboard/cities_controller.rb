module Dashboard
  class CitiesController < ApplicationController
    before_filter :set_user
    before_filter :set_city, only: [:edit, :update, :destroy]
    layout 'dashboard'

    def index
    end

    def edit
    end

    def new
      @city = City.new
    end



    private

    def set_city
       @city = City.find(params[:id])
    end

    def set_user
      @cities = City.all
      @user = current_user
    end


    def city_params
      params.require(:city).permit(:name, :latitude, :longitude, :activated)
    end

  end
end