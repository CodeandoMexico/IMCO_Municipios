module Dashboard
  class UploadsController < ApplicationController
    before_filter :set_city, :set_status
    layout 'dashboard'

    require 'fileutils'

  def index
    unless @status.nil?
      if @status.status == "terminado"
        @logs = true
        @file_success= "#{@root_path_dir}/success.txt"
        @file_errors= "#{@root_path_dir}/errors.txt"
        @file_warnings= "#{@root_path_dir}/warnings.txt"

      elsif @status.status == "iniciado"
        @dialog = true
      end
    end
  end


    def create
      if params[:post]
        file_dependency = params[:post][:dependency_file]
        file_lines = params[:post][:line_file]
        file_inspectors = params[:post][:inspector_file]
        file_requirements = params[:post][:requirement_file]
        file_inspections = params[:post][:inspection_file]
        file_formation_steps = params[:post][:formation_step_file]
        file_procedures = params[:post][:procedure_file]
          if validate_params(file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures) 
                 
            unless @status.nil?
              @status.delete
            end
            @status = Uploads.create(id_user: current_user.id,status: "creado")
            make_files

            if @status.status == "iniciado"
              LoadWorker.perform_async(@user_id,@city.id,file_dependency.tempfile.path, file_lines.tempfile.path, file_inspectors.tempfile.path, file_requirements.tempfile.path, file_inspections.tempfile.path, file_formation_steps.tempfile.path, file_procedures.tempfile.path)
              redirect_to dashboard_upload_index_path,  notice:  "Espere porfavor estamos subiendo los cambios"
            end

          else
            redirect_to dashboard_upload_index_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
          end 
      else
        redirect_to dashboard_upload_index_path,  error:  "Debes agregar todos los datasets  NINGUN CAMBIO FUE EFECTUADO"
      end
    end



  private
    def set_city
      @city = City.find(current_user.city_id)
      @user_id = current_user.id
      @root_path_dir = "lib/temp/upload_#{@user_id}"
      @success = []
      @errors = []
      @warnings = []
    end

    def set_status
      unless Uploads.where(id_user: current_user.id).blank?
        @status = Uploads.where(id_user: current_user).last
        if @status.created_at < Time.now - 15.minutes
          @status.delete
        end
      end
      @dialog = false
      @logs = false
    end

    def validate_params(file_dependency, file_lines, file_inspectors, file_requirements, file_inspections, file_formation_steps, file_procedures)
      if file_lines.blank? || file_lines.blank? || file_inspectors.blank? || file_requirements.blank? || file_inspections.blank? || file_formation_steps.blank? || file_procedures.blank?
        return false
      end
        return true
    end

    def make_files
      @status.status = 'iniciado'
      if @status.save
        delete_files
        Dir::mkdir("#{@root_path_dir}")
        f = File.open("#{@root_path_dir}/success.txt","w+")
        f.close
        f = File.open("#{@root_path_dir}/errors.txt","w+")
        f.close
        f = File.open("#{@root_path_dir}/warnings.txt","w+")
        f.close
        puts '*************************** Archivos creados ***************************'
      end
    end

    def delete_files
      if Dir.exist?("#{@root_path_dir}")
        FileUtils.rm_rf("#{@root_path_dir}")
        puts '*************************** borre el directorio #{@root_path_dir} ***************************'
      else
        puts '*************************** No existe el directorio Nada que borrar***************************'
      end
    end

  end
end