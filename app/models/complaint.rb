class Complaint < ActiveRecord::Base
  belongs_to :municipio

  def validate_and_save(municipio, args)
    if args.fetch(:reason) != 'other'
      self.create(
        municipio: municipio,
        reason: COMPLAINTS[args.fetch(:reason)]
      )
    else
      self.create(
        municipio: municipio,
        reason: args.fetch(:reason),
        custom_reason: args.fetch(:custom_reason)
      )
    end
  end
end
