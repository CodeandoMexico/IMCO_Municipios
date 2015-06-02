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

  def edit
    redirect_to root_path if current_user.nil?
    @user = current_user
    unless @user.city_id.nil?
      @city_select = City.find(@user.city_id).id
      @lines = Line.where(city_id: @user.city_id)
    end

    unless @user.line_id.nil?
      @line_select = Line.find(@user.line_id).id
      @lines = Line.where(city_id: Line.find(@user.line_id).city.id)
    end

    unless params[:city].blank?
      @lines = Line.where(city_id: params[:city])
      @city_select = City.find(params[:city]).id
    end

    unless params[:user_phone].blank?
      @phone = params[:user_phone]
    end
      unless params[:user_schedule].blank?
      @schedule = params[:user_schedule]
    end
    unless params[:bussine_name].blank?
      @bussine_name = params[:bussine_name]
    end
      unless params[:user_operation_license].blank?
      @user_operation_license = params[:user_operation_license]
    end
  end

  def update
    if current_user.admin?
      @user.update_attributes(update_attributes_admin)
      redirect_to dashboard_path, notice: t('flash.users.updated')
    else
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
  end

  def set_cities_and_lines
    @cities = City.order(:name)
    @lines = Line.where(city_id: nil)
  end

  def set_city
    @city = City.find(params[:city_id])
  end
end
