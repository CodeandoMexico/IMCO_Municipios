# heroku run rake mail_tasks:send_reminder
namespace :mail_tasks do
# send email reminder to business
task :send_reminder => :environment do
NUMBER_OF_MAILS = 0
  Reminders.all.each do |reminder|
    case reminder.frequency
    when 1
      if reminder.until_to.to_s == ordenate_date((Date.today-30.day).to_s)
        ComplaintMailer.send_to_business_reminder(reminder).deliver
        reminder.frequency_count += 1
        reminder.save
        NUMBER_OF_MAILS +=1
      end
    when 2
      if reminder.updated_at.to_s == ordenate_date((Date.today-30.day).to_s)
        ComplaintMailer.send_to_business_reminder(reminder).deliver
        reminder.frequency_count += 1
        reminder.save
        NUMBER_OF_MAILS +=1
      end
    when 3
      if reminder.updated_at.to_s == ordenate_date((Date.today-15.day).to_s)
        ComplaintMailer.send_to_business_reminder(reminder).deliver
        reminder.frequency_count += 1
        reminder.save
        NUMBER_OF_MAILS +=1
      end
    when 4
      if reminder.updated_at.to_s == ordenate_date((Date.today-7.day).to_s)
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
    puts "NUMBER_OF_MAILS: #{NUMBER_OF_MAILS}, TIME: #{Time.now}"
end

 def ordenate_date(date)
      fecha = date.split('-')
      return (fecha[0]+"-"+fecha[2]+"-"+fecha[1])
  end
end