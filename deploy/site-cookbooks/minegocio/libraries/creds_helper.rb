module Creds
module Helper
    def list_credentials
        creds = data_bag_item("secrets", "keys")


        list_credentials = []
        creds.keys.each do |key|
            if key !=  "id"
                list_credentials.push "#{key}=#{creds[key]}"
            end
        end
        
        list_credentials
    end
end
end