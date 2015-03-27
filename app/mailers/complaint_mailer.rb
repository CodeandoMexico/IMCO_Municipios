class ComplaintMailer < ActionMailer::Base
  default from: "mikesaurio@gmail.com"

  def send_to_business(user,business)
    @user = user
    @bisiness = business
    mail(to: @user.email, subject: 'Sample Email')
  end

  
end
