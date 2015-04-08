# heroku run rake mail_tasks:send_reminder


namespace :mail_tasks do


# send email reminder to business
task :send_reminder => :environment do

  Reminders.all.each do |reminder|
      if reminder.until_to.to_s == ordenate_date(Date.today.to_s  ) || reminder.until_to .to_s== ordenate_date(Date.today.to_s)
        ComplaintMailer.send_to_business_reminder(reminder).deliver
      end
  end

end


 def ordenate_date(date)
      fecha = date.split('-')
      return (fecha[0]+"-"+fecha[2]+"-"+fecha[1])
    end

end