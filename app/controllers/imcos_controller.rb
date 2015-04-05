class ImcosController < ApplicationController
  after_filter :save_my_previous_url!

#before_filter :authenticate_user! 

  def index
    @cities = City.all.order(:name)
  end


end
