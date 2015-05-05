class ImcosController < ApplicationController
  after_filter :save_my_previous_url!
  layout 'landing'

  def index
    @cities = City.all.order(:name)
    unless current_user.nil?
            unless current_user.city_id.nil?
        redirect_to city_path(current_user.city_id)
      end
    end
  end
end
