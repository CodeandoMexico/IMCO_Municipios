class LearnsController < ApplicationController
  add_breadcrumb "Inicio", :root_path

  def index
    add_breadcrumb "Aprende" 
  end
end