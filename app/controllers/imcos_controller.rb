class ImcosController < ApplicationController
  after_filter :save_my_previous_url!
  before_filter :load_cities
  layout 'landing'

  def index
    unless current_user.nil?
      unless current_business.nil?
        redirect_to city_path(current_business.city_id)
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
