require File.expand_path("../ssh_key", __FILE__)

module Fog
  module Compute
    class Ecloud
      class SshKeys < Fog::Ecloud::Collection
        identity :href

        model Fog::Compute::Ecloud::SshKey

        def all
          data = service.get_ssh_keys(href).body[:SshKey]
          load(data)
        end

        def get(uri)
          if data = service.get_ssh_key(uri)
            new(data.body)
          end
        rescue Fog::Errors::NotFound
          nil
        end
      end
    end
  end
end
