class BusinessController < ApplicationController
    before_action :set_user
    before_filter :set_cities_and_lines
     add_breadcrumb "Inicio", :root_path

  def new
    redirect_to root_path if current_user.nil?
    @user = current_user
    params_temp
  end

  def edit
    @user = current_user
    params_temp
  end

  def create
    if current_user.admin?
      redirect_to dashboard_path, notice: t('flash.users.updated')
    else
      save_params_temp

        business_new = Business.create(name: @user_name,
          address: @address,
          operation_license: @user_operation_license,
          operation_license_file:  @operation_license_file,
          land_permission_file: @land_permission_file,
          city_id: @city_select,
          phone: @phone,
          schedule: @schedule,
          line_id: @line_select,
          latitude: @latitude,
          longitude: @longitude,
          user_id: current_user.id)

      if business_new.save
          redirect_to session[:my_previous_url] , notice: t('flash.users.updated')
      else
        render :new
      end
    end
  end


  def update
    if current_user.admin?
      redirect_to dashboard_path, notice: t('flash.users.updated')
    else
      save_params_temp

        business_new = Business.find(@business.id).update(name: @user_name,
          address: @address,
          operation_license: @user_operation_license,
          operation_license_file:  @operation_license_file,
          land_permission_file: @land_permission_file,
          city_id: @city_select,
          phone: @phone,
          schedule: @schedule,
          line_id: @line_select,
          latitude: @latitude,
          longitude: @longitude,
          user_id: current_user.id)

      if business_new
          redirect_to session[:my_previous_url] , notice: t('flash.users.updated')
      else
        render :edit
      end
    end
  end
  
  def destroy
     @buss = Business.find params[:id]
     if @buss.destroy
      redirect_to edit_user_path(current_user) , notice: t('flash.business.delete')
    end
   end

    private
    def set_user
      @user ||= current_user
      unless params[:id].blank?
        @business = Business.find(params[:id])
        @path = user_business_path
      else
       @business = Business.new
       @path = user_business_index_path
      end
      @array_line=[]
      @array_id=[]
      @algo = "e"
    end

    def set_cities_and_lines
      @cities = City.order(:name)
      @lines = Line.where(city_id: nil)
    end

    def business_params
      params.require(:business).permit(
        :name,
        :address,
        :operation_license,
        :operation_license_file,
        :land_permission_file,
        :city_id,
        :phone,
        :schedule,
        :line_id,
        :latitude,
        :longitude,
        :user_id
        )
    end

  def params_temp
   unless @business.nil?
      unless @business.city_id.nil?
        @city_select = City.find(@business.city_id).id
        @lines = Line.where(city_id: @business.city_id)
      end

      unless @business.line_id.nil?
        @line_select = Line.find(@business.line_id).id
        @lines = Line.where(city_id: Line.find(@business.line_id).city.id)
      end

      unless params[:pagetime].blank?
        @city_select = params[:pagetime][:city_id]
         respond_to do |format|
          format.js  {render :layout => false}
        end
      end

      unless params[:business].blank?
        unless params[:business][:name].blank?
          @user_name = params[:business][:name]
        end

        unless params[:business][:city_id].blank?
          @city_select = City.find(params[:business][:city_id]).id
          @lines = Line.where(city_id: @city_select)
        end

        unless params[:business][:line_id].blank?
          @line_select = Line.find(params[:business][:line_id]).id
        end

        unless params[:business][:phone].blank?
          @phone = params[:business][:phone]
        end

        unless params[:business][:schedule].blank?
          @schedule = params[:business][:schedule]
        end

        unless params[:business][:business_name].blank?
          @business_name = params[:business][:business_name]
        end

        unless params[:business][:operation_license].blank?
          @user_operation_license = params[:business][:operation_license]
        end

        unless params[:business][:address].blank?
          @address = params[:business][:address]
       
        end
      else
        @user_name = @user.name
        @user_email = @user.email
        @city_select = @business.city_id
        @lines = Line.where(city_id: @city_select)
        @line_select  = @business.line_id
        @phone = @business.phone
        @schedule = @business.schedule
        @business_name = @business.name
        @user_operation_license = @business.operation_license
        @address = @business.address
      end  
    end
end


    def save_params_temp
      unless params[:business][:name].blank?
        @user_name = params[:business][:name]
      end
      unless params[:business][:city_id].blank?
        @city_select = City.find(params[:business][:city_id]).id
        @lines = Line.where(city_id: @city_select)
      end
      unless params[:business][:line_id].blank?
        @line_select = Line.find(params[:business][:line_id]).id
      end
      unless params[:business][:phone].blank?
        @phone = params[:business][:phone]
      end
      unless params[:business][:schedule].blank?
        @schedule = params[:business][:schedule]
      end
      unless params[:business][:business_name].blank?
        @bussine_name = params[:business][:business_name]
      end
      unless params[:business][:operation_license].blank?
        @user_operation_license = params[:business][:operation_license]
      end
      unless params[:business][:address].blank?
        @address = params[:business][:address]
      end
      unless params[:business][:latitude].blank?
        @latitude = params[:business][:latitude]
      end
      unless params[:business][:longitude].blank?
        @longitude = params[:business][:longitude]
      end
      unless params[:business][:operation_license_file].blank?
        @operation_license_file = params[:business][:operation_license_file]
      end
      unless params[:business][:land_permission_file].blank?
        @land_permission_file = params[:business][:land_permission_file]
      end
    end 

end