class ComplaintMailer < ActionMailer::Base
  default from: ENV['MAILER_DEFAULT_FROM']

  def send_to_business(user,complaint)
    @user = user
    @complaint = complaint
    mail to: @user.email, subject: I18n.t('mailers.complaints.send_to_business_subject')
  end

   def send_to_municipio(user,complaint)
    @user = user
    @complaint = complaint
    mail to: @user.email, subject: I18n.t('mailers.complaints.send_to_city_subject')
  end
end
