module Dashboard
  class ContactsController < ApplicationController
    before_filter :set_user, :set_municipio
        layout 'dashboard'

    def index
      redirect_to root_path if current_user.nil?
      @user = current_user
      @municipio = Municipio.find(current_user.municipio_id)
   #   @users = User.where(:municipio_id => current_user.municipio_id, :admin =>true)
    end

    def edit
        @municipio = Municipio.find(current_user.municipio_id)
    end


    private

    def set_user
      @user ||= current_user
    end

    def set_municipio
      @municipio ||= Municipio.find(current_user.municipio_id)
    end


  end

end
