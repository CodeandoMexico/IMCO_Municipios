class RemindersController < ApplicationController
  before_action :authenticate_business!
  before_action :business_profile_complete!
  before_action :set_cities
  before_action :set_reminder, only: [:edit, :update, :destroy]
  before_action :reminder_params, only: [:create, :update]
  helper_method :reminders_category

  add_breadcrumb "Inicio", :root_path

  def index
    @reminders = Reminders.where(business_id: current_business)
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
      business_id: current_business.id,
      name: reminder_params[:name],
      license: reminder_params[:license],
      until_to: ordenate_date(reminder_params[:until_to]),
      frequency: reminder_params[:frequency],
      frequency_count: 0
      )
    authorize @reminder

    if @reminder.save
      redirect_to  city_reminders_path(@city),
      notice: 'El recordatorio fue creado satisfactoriamente.' 
    else
      @reminders = Reminders.where(business_id: current_business)
       render :index
    end
  end

  def update
    authorize @reminder
    respond_to do |format|
      if @reminder.update(
        business_id: reminder_params[:business_id],
        name: reminder_params[:name],
        license: reminder_params[:license],
        until_to: ordenate_date(reminder_params[:until_to]),
        frequency: reminder_params[:frequency],
        frequency_count: reminder_params[:frequency_count])

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
    puts fecha
    if fecha.length == 3
      return (fecha[1]+"/"+fecha[0]+"/"+fecha[2]).to_date 
    elsif fecha.length == 1
          fecha = date.split('-')
        if fecha.length == 3
          return (fecha[2]+"-"+fecha[1]+"-"+fecha[0]).to_date 
      end
    end
end

  def set_cities
    @city = City.find(params[:city_id])
    @cities = City.is_activated
  end

  def set_reminder
    @reminder = Reminders.find(params[:id])
  end

  def reminder_params
    params.require(:reminders).permit(
      :business_id,
      :name,
      :license,
      :until_to,
      :frequency,
      :frequency_count
      )
  end

  def reminders_category
      UserTypes.reminders_category
    end
end