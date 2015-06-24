require File.expand_path("../physical_device", __FILE__)

module Fog
  module Compute
    class Ecloud
      class PhysicalDevices < Fog::Ecloud::Collection
        identity :href

        model Fog::Compute::Ecloud::PhysicalDevice

        def all
          data = service.get_physical_devices(href).body[:PhysicalDevice] || []
          load(data)
        end

        def get(uri)
          if data = service.get_physical_device(uri)
            new(data.body)
          end
        rescue Fog::Errors::NotFound
          nil
        end
      end
    end
  end
end
