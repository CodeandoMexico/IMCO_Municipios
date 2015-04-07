class RemindersController < ApplicationController
  layout 'blanco'
  before_action :authenticate_business!
  before_action :business_profile_complete!
  before_action :set_cities
   before_action :set_reminder, only: [:edit, :update, :destroy]
   before_action :complaint_params, only: [:create, :update]

  def edit
  end

  def index
    @reminders = Reminders.where(user_id: current_user)
     @reminder = Reminders.new
  end

  def create
    puts complaint_params[:until_to]
   @reminder = Reminders.new(
                  user: current_user,
                  name: complaint_params[:name],
                  license: complaint_params[:license],
                  until_to: ordenate_date(complaint_params[:until_to])
                 )
  #  authorize @reminder
    if @reminder.save
      redirect_to  city_reminders_path(@city),
        notice: 'El recordatorio fue creado satisfactoriamente.' 
    else
      render :new
    end
  end


  def update
      #authorize @dependency

      respond_to do |format|
        if @reminder.update(complaint_params)
          format.html { redirect_to city_reminders_path(@city), notice: 'El recordatorio fue actualizado satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @reminder }
        else
          format.html { render :edit }
          format.json { render json: @reminder.errors, status: :unprocessable_entity }
        end
      end
    end

   def destroy
      #authorize @inspector

      @reminder.destroy
      respond_to do |format|
        format.html { redirect_to city_reminders_path(@city), notice: 'El recordatorio fue borrado satisfactoriamente.' }
        format.json { head :no_content }
      end
    end

    def ordenate_date(date)
      fecha = date.split('/')
      return (fecha[2]+"/"+fecha[0]+"/"+fecha[1]).to_date
    end

  private

  def set_cities
    @city = City.find(params[:city_id])
    @cities = City.all
  end

  def set_reminder
    @reminder = Reminders.find(params[:id])
  end

  def complaint_params
    params.require(:reminders).permit(
      :name,
      :license,
      :until_to,
      :user
    )
  end
end