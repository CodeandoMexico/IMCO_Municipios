set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 1.day, :at => '6:30 am' do
  rake "mail_tasks:send_reminder"
end