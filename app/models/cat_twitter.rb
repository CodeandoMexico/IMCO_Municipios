class CatTwitter < ActiveRecord::Base

	def state_and_town
    	"#{state} - #{town}"
  	end
end
