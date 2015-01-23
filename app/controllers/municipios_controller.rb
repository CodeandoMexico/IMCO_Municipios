class MunicipiosController < ApplicationController
  layout 'menu'
  before_action :set_municipio, only: [:edit, :update, :destroy]

  def index
    @municipios = Municipio.all
  end

  def show
    set_municipio(:id)
  end
  
  def search
    @municipio = Municipio.find(params[:post][:municipio])
    redirect_to municipio_path(@municipio)
  end

  def new
    @municipio = Municipio.new
  end

  def edit
  end
  


  def tramite
    set_municipio(:municipio_id)
    @procedure = Procedure.all

    @id_del_giro = "0"
    @tipo  = 'A'
    
    unless params[:lines].nil?
      @param_paso = params[:lines]
      @id_del_giro = @param_paso[:line_id]
      @tramites_del_giro = Line.find(@id_del_giro).procedures.includes(:procedure_lines).where("line_id = #{@id_del_giro}") 
      @tipo = params[:rating]
    end
  end


  def inspeccion
        set_municipio(:municipio_id)
  @inspections = Inspection.all

  if params[:q]
    @inspectors = Inspector.search(params[:q]).order("created_at DESC")
  else
    @inspectors = Inspector.all
  end

  @dependency = Dependency.all


  if params[:q]
    @inspections = Inspection.search(params[:q]).order("created_at DESC")
  else
    @inspections = Inspection.all
  end


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
      params.require(:municipio).permit(:nombre)
    end
  end
