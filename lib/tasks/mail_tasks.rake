# heroku run rake mail_tasks:send_reminder
namespace :mail_tasks do
# send email reminder to business
task :send_reminder => :environment do
NUMBER_OF_MAILS = 0
  Reminders.all.each do |reminder|
    case reminder.frequency
    when 1
      if reminder.until_to.to_s == (Date.today-30.day).to_s
        ComplaintMailer.send_to_business_reminder(reminder).deliver
        reminder.frequency_count += 1
        reminder.save
        NUMBER_OF_MAILS +=1
      end
    when 2
      if reminder.updated_at.to_s[0..10] == (Date.today-30.day).to_s
        ComplaintMailer.send_to_business_reminder(reminder).deliver
        reminder.frequency_count += 1
        reminder.save
        NUMBER_OF_MAILS +=1
      end
    when 3
      if reminder.updated_at.to_s[0..10] == (Date.today-15.day).to_s
        ComplaintMailer.send_to_business_reminder(reminder).deliver
        reminder.frequency_count += 1
        reminder.save
        NUMBER_OF_MAILS +=1
      end
    when 4
      if reminder.updated_at.to_s[0..10] == (Date.today-7.day).to_s
        ComplaintMailer.send_to_business_reminder(reminder).deliver
        reminder.frequency_count += 1
        reminder.save
        NUMBER_OF_MAILS +=1
      end
    else
      puts '*********FALLA TASK***************'
    end
  end
    puts '*********TASK********************'
    puts "NUMBER_OF_MAILS RECORDATORIOS: #{NUMBER_OF_MAILS}, TIME: #{Time.now}"

  User.where(admin:  true).each do |user|
    if user.current_sign_in_at.to_s < (Date.today-30.day).to_s
      ComplaintMailer.send_to_not_current_city(user).deliver
      puts "Se envia mail de recordatorio por inactividad a #{user.email}"
    end
  end

end
end