module Dashboard
  class CitiesController < ApplicationController
    before_filter :set_city
    layout 'dashboard'

    def update
    end



    private

    def set_city
      @city ||= City.find(current_user.city_id)
    end

  end
end