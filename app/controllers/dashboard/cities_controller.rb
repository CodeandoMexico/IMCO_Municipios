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
        # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :contact_email, :privacy_file, :contact_phone,:regulations_path, :construction_file, :land_file, :business_file,
        :dependency_file, :line_file, :formation_step_file, :requirement_file, :procedure_file, :inspection_file, :inspector_file)
    end

  end
end