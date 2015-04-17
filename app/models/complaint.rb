class Complaint < ActiveRecord::Base
 validates_presence_of :description, :message => 'Debes escribir la descripción de  lo que sucedió.'
 validates_length_of :description, :minimum => 30, :message => 'La descripción debe tener por lo menos 30 caracteres.'

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
