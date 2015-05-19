module Dashboard
  class ContactsController < ApplicationController
    before_filter :set_user, :set_city
        layout 'dashboard'

    def index
      redirect_to root_path if current_user.nil?
      @user = current_user
      @city = City.find(current_user.city_id)
    end

    def edit
        @city = City.find(current_user.city_id)
    end


    private

    def set_user
      @user ||= current_user
    end

    def set_city
      @city ||= City.find(current_user.city_id)
    end
  end
end
