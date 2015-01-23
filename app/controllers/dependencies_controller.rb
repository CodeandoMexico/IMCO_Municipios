  class DependenciesController < ApplicationController
     layout 'blanco'
    before_action :set_dependency, only: [:show, :edit, :update, :destroy]

    def index
      @dependencies = Dependency.all
    end

    def show
          @municipio = Municipio.all 
    end

    def new
      @dependency = Dependency.new
      @municipio = Municipio.all 
    end

    def edit
          @municipio = Municipio.all 
    end

    def create
      @dependency = Dependency.new(dependency_params)

      respond_to do |format|
        if @dependency.save
          format.html { redirect_to @dependency, notice: 'Dependency was successfully created.' }
          format.json { render :show, status: :created, location: @dependency }
        else
          format.html { render :new }
          format.json { render json: @dependency.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @dependency.update(dependency_params)
          format.html { redirect_to @dependency, notice: 'Dependency was successfully updated.' }
          format.json { render :show, status: :ok, location: @dependency }
        else
          format.html { render :edit }
          format.json { render json: @dependency.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @dependency.destroy
      respond_to do |format|
        format.html { redirect_to dependencies_url, notice: 'Dependency was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_dependency
        @dependency = Dependency.find(params[:id])

      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def dependency_params
        params.require(:dependency).permit(:nombre, :municipio_id)
      end
    end
