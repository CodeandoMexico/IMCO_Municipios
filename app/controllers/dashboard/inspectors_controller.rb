module Dashboard
  class InspectorsController < Dashboard::BaseController
    before_action :set_inspector, only: [:edit, :update, :destroy]
    layout 'dashboard'

    def index
      @inspectors = policy_scope(Inspector)
       respond_to do |format|
        format.html
        format.csv { send_data @inspectors.to_csv }
        format.xls { send_data @inspectors.to_csv(col_sep: "\t") }
    end
    end

    def new
      @inspector = Inspector.new
      @dependency = Dependency.where(city_id: current_user.city_id)
    end

    def edit
    end

    def create
      @inspector = Inspector.new(inspector_params)
      authorize @inspector

      respond_to do |format|
        if @inspector.save
          format.html { redirect_to edit_dashboard_inspector_url(@inspector), notice: 'El inspector fue creado satisfactoriamente.' }
          format.json { render :show, status: :created, location: @inspector }
        else
          format.html { render :new }
          format.json { render json: @inspector.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @inspector

      respond_to do |format|
        if @inspector.update(inspector_params)
          format.html { redirect_to edit_dashboard_inspector_url(@inspector), notice: 'El inspector fue actualizado satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @inspector }
        else
          format.html { render :edit }
          format.json { render json: @inspector.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @inspector

      @inspector.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_inspectors_url, notice:  'El inspector fue borrado satisfactoriamente.' }
        format.json { head :no_content }
      end
    end

    private
    def set_inspector
      @inspector = Inspector.find(params[:id])
    end

    def inspector_params
      params.require(:inspector).permit(:name, :validity, :matter, :supervisor, :contact, :photo, :dependency_id)
    end
  end
end
