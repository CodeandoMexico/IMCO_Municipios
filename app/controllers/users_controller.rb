class UsersController < ApplicationController
  before_filter :set_user
  before_filter :set_cities_and_lines
  before_filter :set_city, only: :index
  add_breadcrumb "Inicio", :root_path

  def index
    @lines = Line.where(city: @city)
    line = Line.find_by(id: params[:line_id])

    if line
      @line_id = line.id
      @users = line.users
    else
      @users = User.where(admin: false, city: @city)
    end

    add_breadcrumb @city.name ,city_path(@city)
    add_breadcrumb "Uso de suelo"
  end

  def new
   @user = current_user
   if params[:sign_in]
     flash[:error] = I18n.t('devise.sessions.user.session_needed_to_continue')
   end
 end

 def create
 end

 def download_csv_business
    respond_to do |format|
      @users = User.where(admin: false, city: params[:city_id])
    format.csv
  end
 end

 def edit
  redirect_to root_path if current_user.nil?
  @user = current_user
  
  unless @user.nil?

    unless @user.city_id.nil?
      @city_select = City.find(@user.city_id).id
      @lines = Line.where(city_id: @user.city_id)
    end

    unless @user.line_id.nil?
      @line_select = Line.find(@user.line_id).id
      @lines = Line.where(city_id: Line.find(@user.line_id).city.id)
    end

    unless params[:pagetime].blank?
      @city_select = params[:pagetime][:city_id]
      respond_to do |format|
        format.js
      end
    end

    unless params[:user].blank?
      unless params[:user][:name].blank?
        @user_name = params[:user][:name]
      end

      unless params[:user][:email].blank?
        @user_email = params[:user][:email]
      end

      unless params[:user][:city_id].blank?
        @city_select = City.find(params[:user][:city_id]).id
        @lines = Line.where(city_id: @city_select)
      end

      unless params[:user][:line_id].blank?
        @line_select = Line.find(params[:user][:line_id]).id
      end

      unless params[:user][:phone].blank?
        @phone = params[:user][:phone]
      end

      unless params[:user][:schedule].blank?
        @schedule = params[:user][:schedule]
      end

      unless params[:user][:business_name].blank?
        @bussine_name = params[:user][:business_name]
      end

      unless params[:user][:operation_license].blank?
        @user_operation_license = params[:user][:operation_license]
      end

      unless params[:user][:address].blank?
        @address = params[:user][:address]
     
      end
    else
      @user_name = @user.name
      @user_email = @user.email
      @city_select = @user.city_id
      @lines = Line.where(city_id: @city_select)
      @line_select  = @user.line_id
      @phone = @user.phone
      @schedule = @user.schedule
      @bussine_name = @user.business_name
      @user_operation_license = @user.operation_license
      @address = @user.address
    end  
  end
end

def update
  if current_user.admin?
    @user.update_attributes(update_attributes_admin)
    redirect_to dashboard_path, notice: t('flash.users.updated')
  else
    save_params_temp
    if @user.update_attributes(user_params)
      redirect_to session[:my_previous_url] , notice: t('flash.users.updated')
    else
      render :edit
    end
  end
end


def create
  @user = User.create(email: :email, password: :password, city_id: current_user.city, admin: true)
  if @user.save?
    redirect_to edit_user_path, notice: t('flash.users.updated')
  else
   redirect_to edit_user_path, notice: t('FALLA')
 end
end


def destroy
  authorize User.find(params[:id])

  User.find(params[:id]).destroy
  respond_to do |format|
    format.html { redirect_to dashboard_dependencies_path notice: 'El usuario fue borrado satisfactoriamente.' }
    format.json { head :no_content }
  end
  redirect_to edit_user_path, notice: t('flash.users.updated')
end

private

def user_params
  params.require(:user).permit(
    :name,
    :email,
    :business_name,
    :address,
    :operation_license,
    :operation_license_file,
    :land_permission_file,
    :city_id,
    :phone,
    :schedule,
    :line_id,
    :latitude,
    :longitude
    )
end

def update_attributes_admin
  params.require(:user).permit(
    :email,
    :password
    )
end

def set_user
  @user ||= current_user
  @array_line=[]
  @array_id=[]
  @algo = "e"
end

def set_cities_and_lines
  @cities = City.order(:name)
  @lines = Line.where(city_id: nil)
end

def set_city
  @city = City.find(params[:city_id])
end

def save_params_temp
  unless params[:user][:name].blank?
    @user_name = params[:user][:name]
  end
  unless params[:user][:email].blank?
    @user_email = params[:user][:email]
  end
  unless params[:user][:city_id].blank?
    @city_select = City.find(params[:user][:city_id]).id
    @lines = Line.where(city_id: @city_select)
  end
  unless params[:user][:line_id].blank?
    @line_select = Line.find(params[:user][:line_id]).id
  end
  unless params[:user][:phone].blank?
    @phone = params[:user][:phone]
  end
  unless params[:user][:schedule].blank?
    @schedule = params[:user][:schedule]
  end
  unless params[:user][:business_name].blank?
    @bussine_name = params[:user][:business_name]
  end
  unless params[:user][:operation_license].blank?
    @user_operation_license = params[:user][:operation_license]
  end
  unless params[:user][:address].blank?
    @address = params[:user][:address]
  end
end 
end
