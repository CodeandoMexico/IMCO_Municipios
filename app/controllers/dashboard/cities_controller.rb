module Dashboard
  class CitiesController < ApplicationController
    before_filter :set_user
    before_filter :set_city, only: [:edit, :update, :destroy]
    layout 'dashboard'

    def index
    end

    def edit
      @admins = User.where(city_id: params[:id])
    end

    def new
      @city = City.new
    end

    def create
      @city = City.new(city_params)

      authorize @user

      respond_to do |format|
        if @city.save
          format.html { redirect_to dashboard_cities_url, notice: 'El Municipio/Delegación fue creada satisfactoriamente.' }
          format.json { render :show, status: :created, location: @city }
        else
          format.html { render :new }
          format.json { render json: @city.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @user

      respond_to do |format|
        if @city.update(city_params)
          format.html { redirect_to dashboard_cities_url, notice: 'El Municipio/Delegación fue actualizado satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @city }
        else
          format.html { render :edit }
          format.json { render json: @city.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @user

      @city.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_cities_path, notice: 'El Municipio/Delegación fue borrado satisfactoriamente.' }
        format.json { head :no_content }
      end
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