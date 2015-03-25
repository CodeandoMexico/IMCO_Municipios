module Dashboard
  class ProceduresController < Dashboard::BaseController
    before_action :set_procedure, only: [:edit, :update, :destroy]
    layout 'dashboard'

    def index
      @procedures = policy_scope(Procedure)

       respond_to do |format|
        format.html
        format.csv { send_data @procedures.to_csv }
        format.xls { send_data @procedures.to_csv(col_sep: "\t") }
    end
    end

    def new
      @procedure = Procedure.new
     @dependencies= Dependency.where(municipio_id: current_user.municipio_id)
     @requirements = Requirement.where(municipio_id: current_user.municipio_id)
     @lines = Line.where(municipio_id: current_user.municipio_id)
    end

    def edit
      @dependencies= Dependency.where(municipio_id: current_user.municipio_id)
      @procedure_requirement= ProcedureRequirement.where(procedure_id: @procedure)
      @requirements = Requirement.where(municipio_id: current_user.municipio_id)
      @lines = Line.where(municipio_id: current_user.municipio_id)
      @procedure_line= ProcedureLine.where(procedure_id: @procedure)
    end

    def create
      @procedure = Procedure.new(procedure_params)
      authorize @procedure
      respond_to do |format|
        if @procedure.save
          create_relation_procedure_requirements
          create_relation_procedure_lines
          format.html { redirect_to edit_dashboard_procedure_url(@procedure), notice: 'El trámite fue creado satisfactoriamente.' }
          format.json { render :show, status: :created, location: @procedure }
        else
          format.html { render :new }
          format.json { render json: @procedure.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @procedure
      respond_to do |format|
        if @procedure.update(procedure_params)
          delete_relation_procedure_requirements
          create_relation_procedure_requirements
          delete_relation_procedure_lines
          create_relation_procedure_lines
          format.html { redirect_to edit_dashboard_procedure_url(@procedure), notice: 'El trámite fue actualizádo satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @procedure}
        else
          format.html { render :edit }
          format.json { render json: @requirement.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @procedure
      delete_relation_procedure_requirements
      delete_relation_procedure_lines
      @procedure.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_procedures_path notice: 'El trámite fue borrado satisfactoriamente.' }
        format.json { head :no_content }
      end
    end

    private
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    def procedure_params
      params.require(:procedure).permit(:nombre, :duracion, :costo, :vigencia, :contacto, :tipo, :dependency_id, :categoria, :sare, :procedure=>{:requirement_ids => []}, :procedure=>{:line_ids => []})
    end

    def create_relation_procedure_requirements
        params[:procedure][:requirement_ids].each do |par|
              if par.present?
              @procedure_requirement = ProcedureRequirement.create(procedure_id: @procedure.id, requirement_id: par)
              @procedure_requirement.save
              end
          end
    end

    def delete_relation_procedure_requirements
      ProcedureRequirement.all.each do |par|
            @id = ProcedureRequirement.where(procedure_id: @procedure.id, requirement_id: par.requirement_id).pluck(:id)
            @procedure_requirement = ProcedureRequirement.destroy(@id)
        end
    end


     def create_relation_procedure_lines
        params[:procedure][:line_ids].each do |par|
              if par.present?
              @procedure_line = ProcedureLine.create(procedure_id: @procedure.id, line_id: par)
              @procedure_line.save
              end
          end
    end

    def delete_relation_procedure_lines
      ProcedureLine.all.each do |par|
            @id = ProcedureLine.where(procedure_id: @procedure.id, line_id: par.line_id).pluck(:id)
            @procedure_line = ProcedureLine.destroy(@id)
        end
    end

  end


end
