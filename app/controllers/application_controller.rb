class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  after_action :store_location
  layout :layout_by_resource
  add_flash_types :error, :notice, :alert
  before_action :set_client_user_voice
  helper_method :current_business, :current_businesses 

  def set_client_user_voice
    require 'uservoice-ruby'    
      unless envirement_validates
        client = UserVoice::Client.new(ENV['USERVOICE_SUBDOMAIN_NAME'], ENV['USERVOICE_API_KEY'], ENV['USERVOICE_API_SECRET'])
        begin 
          client.login_as_owner do |owner|
           user = owner.get("/api/v1/users/current")['user']
          end
        rescue Exception => e
          puts "Sin conexión -UserVoice-" 
        end 
      end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def verify_admin
    admin_is_logged_in? || not_found
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end


  def after_sign_in_path_for(resource)
    return dashboard_path if resource.admin?
    if validaDatos(resource)
          return   session[:my_previous_url]
        else
          return  edit_user_path(resource)
      end
    #return  root_path if resource.profile_complete?
    #edit_user_path(resource)
  end

  def authenticate_business!
    if !user_signed_in? #|| !current_user.business?
      return redirect_to new_user_path, error: I18n.t('devise.sessions.user.session_needed_to_continue')
    end
  end

  def business_profile_complete!
   unless validaDatos(current_user)
     return redirect_to  edit_user_path(current_user) , error: I18n.t('flash.complaints.you_need_to_complete_your_profile')
   end
  end


  def save_my_previous_url!
    session[:my_previous_url] = request.fullpath
  end

  protected

  def layout_by_resource
    # Do we want a custom layout for views when there's a user
    # involved but, is not an admin?
    if devise_controller? && resource && !resource.admin?
      'session'
    elsif devise_controller?
      'session'
    end
  end

  #Cambia el estado de todos los negocio a no preferente y solo el seleccionado tiene true
  def set_business_used(business_id)
    Business.where(user_id: current_user).each do |business|
          business.using = false
          business.save
    end
      business = Business.find(business_id)
      business.using = true
      business.save

      redirect_to city_path(Business.find(business_id).city_id), notice: Business.find(business_id).name
  end

  #regresa el negocio activo
  def current_business
    business = Business.where(user_id: current_user, using: true)
    unless business.empty?
      return business.last
    end
      return nil
  end

  #regresa todos los negocios de un usuario
  def current_businesses
    Business.where(user_id: current_user)
  end

  private
  def admin_is_logged_in?
    authenticate_user! && current_user.admin?
  end

  def validaDatos(resource)
    !resource.email.blank?#&&!resource.address.blank?&&!resource.name.blank?&&!resource.business_name.blank?&&!resource.operation_license.blank?
   end

   def envirement_validates
         ENV['USERVOICE_SUBDOMAIN_NAME'].nil? || ENV['USERVOICE_API_SECRET'].nil? || ENV['USERVOICE_API_KEY'].nil?
    end
end
