require File.expand_path("../login_banner", __FILE__)

module Fog
  module Compute
    class Ecloud
      class LoginBanners < Fog::Ecloud::Collection
        identity :href

        model Fog::Compute::Ecloud::LoginBanner

        def all
          data = service.get_login_banners(href).body
          load(data)
        end

        def get(uri)
          if data = service.get_login_banner(uri)
            new(data.body)
          end
        rescue Fog::Errors::NotFound
          nil
        end
      end
    end
  end
end
