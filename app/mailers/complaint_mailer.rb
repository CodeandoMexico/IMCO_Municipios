class ComplaintMailer < ActionMailer::Base
  default from: ENV['MAILER_DEFAULT_FROM']

  def send_to_business(complaint)
    @complaint = complaint
    mail to: @complaint.user.email, subject: I18n.t('mailers.complaints.send_to_business_subject')
  end
  
  def send_to_business_reminder(reminder)
    @reminder = reminder
    mail to: User.find(@reminder.user_id).email, subject: I18n.t('mailers.reminders.send_to_bussines_reminder_subject')
  end

   def send_to_city(complaint)
    @complaint = complaint
    if @complaint.city.contact_email.nil? || @complaint.city.contact_email.empty?
        User.all.where(city_id: complaint.city, admin: true).each do |admin|
          mail to: admin.email, subject: I18n.t('mailers.complaints.send_to_city_subject')
        end
    else
      mail to: @complaint.city.contact_email, subject: I18n.t('mailers.complaints.send_to_city_subject')
    end
  end

  def send_to_business_password(email)
    mail to: email 
  end

end
