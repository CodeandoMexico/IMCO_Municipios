class PasswordsController < Devise::PasswordsController

#  def new
#     super
#   end

#   def create
#     correo = params[:user][:email] 
#     unless correo.nil? || correo.empty?
#      user = User.where(email: correo)
#      unless user.empty?
#       ComplaintMailer.send_to_business_password(user.last).deliver
#       redirect_to  user_session_path, notice:  t('flash.users.ok') 
#     else
#      redirect_to  new_user_password_path, error:  t('flash.users.not_found') 
#    end
#  else
#   redirect_to  new_user_password_path, error:  t('flash.users.blank') 
# end 
# end

def update

end

end