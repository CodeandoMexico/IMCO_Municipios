class LearnsController < ApplicationController
  add_breadcrumb "Inicio", :root_path

  def index
    add_breadcrumb "Aprende" 
    @learns = Learn.order(:category)
  end

  def show
    add_breadcrumb "Aprende", :learns_path
    add_breadcrumb "Video"
    @learn = Learn.find(params[:id])
  end


end