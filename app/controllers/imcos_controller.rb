class ImcosController < ApplicationController
  

  def index
    @municipios = Municipio.all

     if params[:query].present?
      @results = Municipio.search(params[:query], nombre: params[:nombre])
    else
      @results = Municipio.all
    end

  end
end
