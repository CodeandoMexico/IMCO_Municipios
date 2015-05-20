class RemindersController < ApplicationController
  before_action :authenticate_business!
  before_action :business_profile_complete!
  before_action :set_cities
  before_action :set_reminder, only: [:edit, :update, :destroy]
  before_action :reminder_params, only: [:create, :update]

  add_breadcrumb "Inicio", :root_path

  def index
    @reminders = Reminders.where(user: current_user)
    @reminder = Reminders.new

    add_breadcrumb @city.name ,city_path(@city)
    add_breadcrumb "Inspecciones", city_inspections_path(@city)
    add_breadcrumb "Recordatorios"
  end

  def edit
    add_breadcrumb @city.name ,city_path(@city)
    add_breadcrumb "Inspecciones", city_inspections_path(@city)
    add_breadcrumb "Recordatorios" , city_reminders_path(@city)
     add_breadcrumb "Editar recordatorio"
  end

  def create
    @reminder = Reminders.new(
      user: current_user,
      name: reminder_params[:name],
      license: reminder_params[:license],
      until_to: ordenate_date(reminder_params[:until_to])
      )
    authorize @reminder

    if @reminder.save
      redirect_to  city_reminders_path(@city),
      notice: 'El recordatorio fue creado satisfactoriamente.' 
    else
      @reminders = Reminders.where(user: current_user)
       render :index
    end
  end

  def update
    authorize @reminder

    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to city_reminders_path(@city), notice:  'El recordatorio fue actualizado satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @reminder }
      else
        format.html { render :edit }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @reminder

    @reminder.destroy
    respond_to do |format|
      format.html { redirect_to city_reminders_path(@city), notice:  'El recordatorio fue borrado satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  

  private

def ordenate_date(date)
    fecha = date.split('/')
    if fecha.length == 3
      return (fecha[2]+"/"+fecha[0]+"/"+fecha[1]).to_date 
    elsif fecha.length == 1
          fecha = date.split('-')
        if fecha.length == 3
          return (fecha[2]+"-"+fecha[0]+"-"+fecha[1]).to_date 
      end
    end
end

  def set_cities
    @city = City.find(params[:city_id])
    @cities = City.all
  end

  def set_reminder
    @reminder = Reminders.find(params[:id])
  end

  def reminder_params
    params.require(:reminders).permit(
      :name,
      :license,
      :until_to
      )
  end
end