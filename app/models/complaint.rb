class Complaint < ActiveRecord::Base
  belongs_to :city
  belongs_to :user

  after_create :send_emails

  private

  def send_emails
    # Send mails
     ComplaintMailer.send_to_business(self).deliver
     ComplaintMailer.send_to_city(self).deliver
  end
end
