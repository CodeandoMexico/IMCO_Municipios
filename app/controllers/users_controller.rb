class UsersController < ApplicationController
  before_filter :set_user
  before_filter :set_city
  layout 'session'

  def new
   @user = current_user
  end

   def create
   end

   def edit
    @lines = Line.where(name: 'false')
    redirect_to root_path if current_user.nil?
    @user = current_user
    unless @user.city_id.nil?
      @city_select = City.find(@user.city_id).id
      @lines = Line.where(city_id: @user.city_id)
    end
    unless @user.line_id.nil?
      @line_select = Line.find(@user.line_id).id
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

  def set_city
    @cities = City.order(:name)
  end
end
