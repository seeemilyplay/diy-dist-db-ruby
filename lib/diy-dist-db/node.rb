require 'rest-client'
require 'json'
require_relative 'thing'

module Node
    def Node.get_thing(url, id)
        response = RestClient.get "#{url}/things/#{id}"
        Thing.from_json(JSON.parse(response.to_str))
    end

    def Node.put_thing(url, thing)
        response = RestClient.post(
                       "#{url}/things",
                       thing.to_json,
                       :content_type => :json) 
    end
end
