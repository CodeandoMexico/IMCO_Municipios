class RemindersController < ApplicationController
  layout 'blanco'
  before_action :authenticate_business!
  before_action :business_profile_complete!
  before_action :set_cities
  before_action :complaint_params, only: [:create, :update]

  def new
    @reminder = Reminders.new
  end

  def index
    @reminders = Reminders.where(user_id: current_user)
     @reminder = Reminders.new
  end

  def create
   @reminder = Reminders.new(
                  user: current_user,
                  name: complaint_params[:name],
                  license: complaint_params[:license],
                  until_to: complaint_params[:until_to],

                 )
  #  authorize @reminder
    if @reminder.save
      redirect_to  city_reminders_path(@city),
        notice: I18n.t('complaints.created_successfully')
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

   def destroy
      #authorize @inspector

      Reminders.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to city_reminders_path(@city), notice: 'El recordatorio fue borrado satisfactoriamente.' }
        format.json { head :no_content }
      end
    end

  private

  def set_cities
    @city = City.find(params[:city_id])
    @cities = City.all
  end

  def complaint_params
    params.require(:reminders).permit(
      :name,
      :license,
      :until_to,
      :user_id
    )
  end
end