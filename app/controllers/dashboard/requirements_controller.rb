module Dashboard
  class RequirementsController < Dashboard::BaseController
    before_action :set_requirement, only: [:edit, :update, :destroy]
    layout 'dashboard'

    def index
      @requirements = policy_scope(Requirement).where(municipio_id: current_user.municipio).order(:nombre)

       respond_to do |format|
        format.html
        format.csv { send_data @requirements.to_csv }
        format.xls { send_data @requirements.to_csv(col_sep: "\t") }
    end

    end

    def new
      @requirement = Requirement.new
    end

    def edit
    end

    def create
      @requirement = Requirement.new(requirement_params)
      @requirement.municipio = current_user.municipio
      authorize @requirement

      respond_to do |format|
        if @requirement.save
          format.html { redirect_to edit_dashboard_requirement_url(@requirement), notice: 'El requerimiento fue creado satisfactoriamente.' }
          format.json { render :show, status: :created, location: @requirement }
        else
          format.html { render :new }
          format.json { render json: @requirement.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @requirement

      respond_to do |format|
        if @requirement.update(requirement_params)
          format.html { redirect_to edit_dashboard_requirement_url(@requirement), notice: 'El requerimiento fue actualizado satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @requirement}
        else
          format.html { render :edit }
          format.json { render json: @requirement.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @requirement

      @requirement.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_requirements_path notice: 'El requerimiento fue borrado satisfactoriamente.' }
        format.json { head :no_content }
      end
    end

    private
    def set_requirement
      @requirement = Requirement.find(params[:id])
    end

    def requirement_params
      params.require(:requirement).permit(:nombre, :descripcion, :path, :type, :municipio_id)
    end
  end
end
