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
   @states = CatTwitter.order(:state)
   @twitter_gov = nil
    unless params[:pagetime].blank?
      @twitter_gov = CatTwitter.find(params[:pagetime][:state_id]).twitter
      respond_to do |format|
        format.js  {render :layout => true}
      end
    end
   @twitter_app= "miNegocioMexico"
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
