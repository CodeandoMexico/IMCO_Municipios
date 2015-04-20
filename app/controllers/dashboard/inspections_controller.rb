module Dashboard
  class InspectionsController < Dashboard::BaseController
    before_action :set_inspection, only: [:edit, :update, :destroy]
    layout 'dashboard'

    def index
      @inspections = policy_scope(Inspection)
       respond_to do |format|
        format.html
        format.csv { send_data @inspections.to_csv }
        format.xls { send_data @inspections.to_csv(col_sep: "\t") }
    end
    end

    def new
      @inspection = Inspection.new
      @dependency = Dependency.where(city_id: current_user.city_id)
      @lines = Line.where(city_id: current_user.city_id)
        @requirements = Requirement.where(city_id: current_user.city_id)
    end

    def edit
      @dependency = Dependency.where(city_id: current_user.city_id)
      @lines = Line.where(city_id: current_user.city_id)
      @inspection_line= InspectionLine.where(inspection_id: @inspection)
      @inspection_requirement= InspectionRequirement.where(inspection_id: @inspection)
      @requirements = Requirement.where(city_id: current_user.city_id)
      end

    def create
      @inspection = Inspection.new(inspection_params)
      authorize @inspection

      respond_to do |format|
        if @inspection.save
          create_relation_inspection_requirements
          create_relation_inspection_lines
          format.html { redirect_to edit_dashboard_inspection_url(@inspection), notice: 'La inspección fue creada satisfactoriamente.' }
          format.json { render :show, status: :created, location: @inspection }
        else
          format.html { render :new }
          format.json { render json: @inspection.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @inspection

      respond_to do |format|
        if @inspection.update(inspection_params)
           delete_relation_inspection_lines
          create_relation_inspection_lines
          delete_relation_inspection_requirements
          create_relation_inspection_requirements
          format.html { redirect_to edit_dashboard_inspection_url(@inspection), notice: 'La inspección fue actualizada satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @inspection }
        else
          format.html { render :edit }
          format.json { render json: @inspection.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @inspection
     delete_relation_inspection_lines
      delete_relation_inspection_requirements
      @inspection.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_inspections_url, notice: 'La inspección fue borrada satisfactoriamente.' }
        format.json { head :no_content }
      end
    end

    private
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    def inspection_params
      params.require(:inspection).permit(:name, :matter, :duration, :rule, :after, :before, :during, :sanction, :dependency_id, :inspection=>{:line_ids => []},:inspection=>{:requirement_ids => []})
    end

    def create_relation_inspection_lines
        params[:inspection][:line_ids].each do |par|
              if par.present?
              @inspection_line = InspectionLine.create(inspection_id: @inspection.id, line_id: par)
              @inspection_line.save
              end
          end
    end

    def delete_relation_inspection_lines
      InspectionLine.all.each do |par|
            @id = InspectionLine.where(inspection_id: @inspection.id, line_id: par.line_id).pluck(:id)
            @inspection_line = InspectionLine.destroy(@id)
        end
    end

def create_relation_inspection_requirements
        params[:inspection][:requirement_ids].each do |par|
              if par.present?
              @inspection_requirement = InspectionRequirement.create(inspection_id: @inspection.id, requirement_id: par)
              @inspection_requirement.save
              end
          end
    end

    def delete_relation_inspection_requirements
      InspectionRequirement.all.each do |par|
            @id = InspectionRequirement.where(inspection_id: @inspection.id, requirement_id: par.requirement_id).pluck(:id)
            @inspection_requirement = InspectionRequirement.destroy(@id)
        end
    end


  end
end
