module Dashboard
  class AdminsController < ApplicationController
    before_filter :set_user, only: [:edit, :update]
    layout 'dashboard'

    def index
    end

    def new
      @user = User.new
      if params[:city_id]
        $city_id = City.find(params[:city_id])
      end
      
    end

    def create
    end

    def edit
      @city = @user.city_id
    end


    def create
      @user = User.new(user_params)
      puts '********************************'
      puts $city_id.id
      @user.city_id = $city_id.id
      @user.admin = true

      respond_to do |format|
        if @user.save
          format.html { redirect_to edit_dashboard_city_path(@user.city_id), notice: 'El adminsitrador fue creada satisfactoriamente.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      puts '***************'
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to dashboard_path, notice: 'El adminsitrador fue actualizado satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      id_user = params[:user_id]
      id_city = User.find(id_user).city_id
      User.find(id_user).destroy
      respond_to do |format|
        format.html { redirect_to edit_dashboard_city_path(id_city), notice: 'El adminsitrador fue borrado satisfactoriamente.' }
        format.json { head :no_content }
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password
        )
    end

    def set_user
      @user = User.find(params[:id])
    end

  end
end