class LearnsController < ApplicationController
  add_breadcrumb "Inicio", :root_path

  def index
    add_breadcrumb "Aprende"
    @learns = Learn.where(for_admin: current_is_admin?)
  end

  def show
    add_breadcrumb "Aprende", :learns_path
    add_breadcrumb "Video"
    @learn = Learn.find(params[:id])
  end


end