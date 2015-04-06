module Dashboard
  class FormationStepsController < Dashboard::BaseController
    before_action :set_formation_steps, only: [:edit, :update, :destroy]
    layout 'dashboard'

    def index
      @formation_steps = policy_scope(FormationStep).where(city_id: current_user.city).order(:name)
       respond_to do |format|
        format.html
        format.csv { send_data @formation_steps.to_csv }
        format.xls { send_data @formation_steps.to_csv(col_sep: "\t") }
    end
    end

    def new
      @formation_step = FormationStep.new
      @dependency = Dependency.where(city_id: current_user.city_id)
    end

    def edit
          @dependency = Dependency.where(municicity_idpio_id: current_user.city_id)
    end

    def create
      @formation_step = FormationStep.new(formation_steps_params)
      @formation_step.city = current_user.city
      authorize @formation_step

      respond_to do |format|
        if @formation_step.save
          format.html { redirect_to edit_dashboard_formation_step_url(@formation_step), notice: 'formation step was successfully created.' }
          format.json { render :show, status: :created, location: @formation_step }
        else
          format.html { render :new }
          format.json { render json: @formation_step.errors, status: :unprocessable_entity }
        end
      end
    end

     def update
    respond_to do |format|
      if @formation_step.update(formation_steps_params)
        format.html { redirect_to edit_dashboard_formation_step_url(@formation_step), notice: 'formation_step was successfully updated.' }
        format.json { render :show, status: :ok, location: @formation_step }
      else
        format.html { render :edit }
        format.json { render json: @formation_step.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
      authorize @formation_step
      @formation_step.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_formation_steps_path, notice: 'Inspection was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    def set_formation_steps
      @formation_step = FormationStep.find(params[:id])
    end

    def formation_steps_params
      params.require(:formation_step).permit(:name, :description, :type, :path, :city_id )
    end
  end
end
