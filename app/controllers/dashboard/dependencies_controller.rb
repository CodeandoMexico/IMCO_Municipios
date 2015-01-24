module Dashboard
  class DependenciesController < ApplicationController
    before_action :set_line, only: [:edit, :update, :destroy]
    before_action :authenticate_user!
    layout 'dashboard'

    def index 
      @dependencies = policy_scope(Dependency)
    end

    def new
      @line = Line.new
      @dependency = Dependency.where(municipio_id: current_user.municipio_id)
    end

    def edit
      @dependency = Dependency.where(municipio_id: current_user.municipio_id)
    end

    def create
      @line = Line.new(line_params)
      @line.municipio = current_user.municipio
      authorize @line

      respond_to do |format|
        if @line.save
          format.html { redirect_to edit_dashboard_line_url(@line), notice: 'El giro fue creado satisfactoriamente.' }
          format.json { render :show, status: :created, location: @line }
        else
          format.html { render :new }
          format.json { render json: @line.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @line

      respond_to do |format|
        if @line.update(line_params)
          format.html { redirect_to edit_dashboard_line_url(@line), notice: 'El giro fue actualizado satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @line }
        else
          format.html { render :edit }
          format.json { render json: @line.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @line

      @line.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_lines_path notice: 'El giro fue borrado satisfactoriamente.' }
        format.json { head :no_content }
      end
    end

    private
    def set_line
      @line = Line.find(params[:id])
    end

    def line_params
      params.require(:line).permit(:nombre, :descripcion, :municipio_id)
    end
  end
end
