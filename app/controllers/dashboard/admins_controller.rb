module Dashboard
  class AdminsController < ApplicationController
    before_filter :set_user
    layout 'dashboard'

    def edit
    end



    private

    def set_user
      @user = current_user
    end

  end
end