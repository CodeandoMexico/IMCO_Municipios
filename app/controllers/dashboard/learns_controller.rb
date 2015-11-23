module Dashboard
	class LearnsController < Dashboard::BaseController
		before_action :validate_user
  	
  	def index
		  
  	end



  private 

	def validate_user
		unless current_user.is_super_user
		  redirect_to root_path
		end
	end

	end
end