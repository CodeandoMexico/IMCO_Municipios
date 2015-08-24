require File.expand_path("../rnat", __FILE__)

module Fog
  module Compute
    class Ecloud
      class Rnats < Fog::Ecloud::Collection
        identity :href

        model Fog::Compute::Ecloud::Rnat

        def all
          data = service.get_rnats(href).body[:Rnats][:Rnat]
          load(data)
        end

        def get(uri)
          if data = service.get_rnat(uri)
            new(data.body)
          end
        rescue Fog::Errors::NotFound
          nil
        end
      end
    end
  end
end
