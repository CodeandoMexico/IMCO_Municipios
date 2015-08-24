require File.expand_path("../api_key", __FILE__)

module Fog
  module Compute
    class Ecloud
      class ApiKeys < Fog::Ecloud::Collection
        identity :href

        model Fog::Compute::Ecloud::ApiKey

        def all
          data = service.get_api_keys(href).body
          load(data)
        end

        def get(uri)
          if data = service.get_api_key(uri)
            new(data.body)
          end
        rescue Fog::Errors::NotFound
          nil
        end
      end
    end
  end
end
