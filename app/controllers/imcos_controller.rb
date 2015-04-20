class ImcosController < ApplicationController
  after_filter :save_my_previous_url!
  layout 'landing'

  def index
    @cities = City.all.order(:name)
  end
end
