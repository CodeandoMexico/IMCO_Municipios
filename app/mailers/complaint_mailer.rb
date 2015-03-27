class ComplaintMailer < ActionMailer::Base
  default from: "mikesaurio@gmail.com"

  def send_to_business(user,complaint)
    @user = user
    @complaint = complaint
    mail(to: @user.email, subject: 'Denuncia enviada correctamente')
  end

   def send_to_municipio(user,complaint)
    @user = user
    @complaint = complaint
    mail(to: @user.email, subject: 'Denuncia de inspección recibida')
  end
end
