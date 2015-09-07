class ImcosController < ApplicationController
  after_filter :save_my_previous_url!
  before_filter :load_cities
  layout 'landing'

  def index
    unless current_user.nil?
      city = Business.where(user_id: current_user, using: true)
      unless city.blank?
        redirect_to city_path(city.last.id)
      end
    end
  end

  def change_business

    unless params[:business].blank?
        set_business_used(params[:business])
    end
  end

private

def load_cities
  @cities = City.all.order(:name)
end

end
