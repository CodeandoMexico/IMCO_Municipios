class Complaint < ActiveRecord::Base
  belongs_to :municipio

  def validate_and_save(municipio, args)
    # This custom method is to sanitize and validate
    # the answer.
    if args.fetch(:reason) != 'other'
      reason = COMPLAINTS[args.fetch(:reason)]
      custom_reason = nil
    else
      reason = args.fetch(:reason)
      custom_reason = args.fetch(:custom_reason)
    end

    # update the object content
    self.municipio_id = municipio.id
    self.reason = reason
    self.custom_reason = custom_reason
    self.description = args.fetch(:description)

    self.save
  end
end
