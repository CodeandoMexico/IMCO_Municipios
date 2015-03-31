class MunicipiosController < ApplicationController
  layout 'menu'
  before_action :set_municipio, only: [:edit, :update, :destroy]

  
  def show
    @municipios = Municipio.all
    set_municipio(:id)
  end
  
  def search
    @municipio = Municipio.find(params[:post][:municipio])
    redirect_to municipio_path(@municipio)
  end

  def about

    @municipios = Municipio.all
    set_municipio(:municipio_id)
          render layout: 'blanco'
  end

  def aviso

    @municipios = Municipio.all
    set_municipio(:municipio_id)
        render layout: 'blanco'
  end



  def create
    @municipio = Municipio.new(municipio_params)

    respond_to do |format|
      if @municipio.save
        format.html { redirect_to @municipio, notice: 'Municipio was successfully created.' }
        format.json { render :show, status: :created, location: @municipio }
      else
        format.html { render :new }
        format.json { render json: @municipio.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @municipio.update(municipio_params)
        format.html { redirect_to @municipio, notice: 'Municipio was successfully updated.' }
        format.json { render :show, status: :ok, location: @municipio }
      else
        format.html { render :edit }
        format.json { render json: @municipio.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @municipio.destroy
    respond_to do |format|
      format.html { redirect_to municipios_url, notice: 'Municipio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_municipio(val)
      @municipio = Municipio.find(params[val])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def municipio_params
      params.require(:municipio).permit(:nombre, :contact_email)
    end
  end
