class BusinessController < ApplicationController
    before_action :set_user, only: [:show]
    before_filter :set_cities_and_lines
     add_breadcrumb "Inicio", :root_path

    def new
        redirect_to root_path if current_user.nil?
        @user = current_user
        @business = Business.new

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
        @business_name = params[:user][:business_name]
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

    private
    def set_user
      @user =  User.find(params[:id])
    end

    def set_cities_and_lines
      @cities = City.order(:name)
      @lines = Line.where(city_id: nil)
    end
  end