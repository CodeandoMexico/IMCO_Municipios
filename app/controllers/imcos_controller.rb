class ImcosController < ApplicationController
  

#before_filter :authenticate_user! 

  def index
    @municipios = Municipio.all.order(:nombre)

   #  if params[:query].present?
     # @results = Municipio.search(params[:query], nombre: params[:nombre])
    #else
     # @results = Municipio.all
   # end

  end
end
