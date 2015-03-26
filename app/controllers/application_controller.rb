class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  after_action :store_location
  layout :layout_by_resource

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
    return root_path if resource.profile_complete?
    edit_user_path(resource)
  end

  def authenticate_business!
    if !user_signed_in? || !current_user.business?
      return redirect_to new_user_path, alert: I18n.t('devise.sessions.user.session_needed_to_continue')
    end
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

  private

  def admin_is_logged_in?
    authenticate_user! && current_user.admin?
  end
end
