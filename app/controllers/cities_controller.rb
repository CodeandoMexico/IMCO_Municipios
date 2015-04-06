class CitiesController < ApplicationController
  layout 'menu'
#  before_action :set_municipio, only: [:edit, :update, :destroy]

  
  def show
    @cities = City.all
    set_city(:id)
  end
  
  def search
    @city = City.find(params[:post][:city])
    redirect_to city_path(@city)
  end

  def about

    @cities = City.all
          set_city(:city_id)
          render layout: 'blanco'
  end

  def aviso

    @cities = City.all
    set_city(:city_id)
        render layout: 'blanco'
  end

def edit

end



  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
     @city = City.find(params[:id])
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to  dashboard_city_contacts_path(@city), notice: t('flash.users.updated') }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice: 'city was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city(val)
      unless params[val].nil?
      @city = City.find(params[val])
    else
      @city = City.find(params[:id])
    end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :contact_email)
    end
  end
