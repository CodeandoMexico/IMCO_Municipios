class CitiesController < ApplicationController
  add_breadcrumb "Inicio", :root_path

  def show
    @cities = City.is_activated
    set_city(:id)
    add_breadcrumb @city.name 
  end

  def search
    @city = City.find(params[:post][:city])
    redirect_to city_path(@city)
  end

  def about
    @cities = City.is_activated
    set_city(:city_id)
  end

  def aviso
    @cities = City.is_activated
    set_city(:city_id)
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
        format.html { redirect_to  dashboard_city_contacts_path(@city), notice:  t('flash.users.updated') }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice:  'city was successfully destroyed.' }
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
      params.require(:city).permit(:name, :contact_email, :privacy_file, :contact_phone,:regulations_path, :construction_file, :land_file, :business_file,
        :dependency_file, :line_file, :formation_step_file, :requirement_file, :procedure_file, :inspection_file, :inspector_file,:has_federal_documentation,:has_state_documentation)
    end
  end
