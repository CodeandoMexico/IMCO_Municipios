module Dashboard
	class LearnsController < Dashboard::BaseController
		before_action :validate_user
		before_action :set_learn, only: [:edit, :update, :destroy]
		layout 'dashboard'
  	
  	def index
		  @learns = Learn.all
  	end

  	def new
  		@learn = Learn.new
  	end

  	def edit
  	end


  	def create
  		@learn = Learn.new(learn_params)
      respond_to do |format|
        if @learn.save
          format.html { redirect_to dashboard_learn_url, notice: 'El video fue creado satisfactoriamente.' }
          format.json { render :show, status: :created, location: @learn }
        else
          format.html { render :new }
          format.json { render json: @learn.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @learn.update(learn_params)
          format.html { redirect_to dashboard_learns_url, notice:  'El video fue actualizado satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @learn }
        else
          format.html { render :edit }
          format.json { render json: @learn.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @learn.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_learns_path notice:  'El video fue borrado satisfactoriamente.' }
        format.json { head :no_content }
      end
    end



  private 

  def set_learn
  	 @learn = Learn.find(params[:id])
  end

	def validate_user
		unless current_user.is_super_user
		  redirect_to root_path
		end
	end

	 def learn_params
      params.require(:learn).permit(:name, :description, :video_id, :category)
    end

	end
end