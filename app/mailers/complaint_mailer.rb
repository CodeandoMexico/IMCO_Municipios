class ComplaintMailer < ActionMailer::Base
  default from: ENV['MAILER_DEFAULT_FROM']

  def send_to_business(complaint)
    @complaint = complaint
    mail to: @complaint.user.email, subject: I18n.t('mailers.complaints.send_to_business_subject')
  end

   def send_to_municipio(complaint)
    @complaint = complaint
    mail to: @complaint.municipio.contact_email, subject: I18n.t('mailers.complaints.send_to_city_subject')
  end
end
