module Dashboard
  class BusinessController < ApplicationController
    before_filter  :set_city
    before_action :set_user, only: [:show]
    layout 'dashboard'

    def index
      redirect_to root_path if current_user.nil?
    end

    def show
    end


    private

    def set_user
      @user =  User.find(params[:id])
    end

    def set_city
      @city ||= City.find(current_user.city_id)
      @users =  User.where(city_id: @city.id, admin: false)
    end
  end
end
