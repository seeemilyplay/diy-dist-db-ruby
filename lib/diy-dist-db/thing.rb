require 'date'

class Thing
    attr_accessor :timestamp

    def initialize(id, value, timestamp=Time.now.to_i*1000)
        @id = id
        @value = value
        @timestamp = timestamp 
    end

    def to_json
        {'Id' => @id,
         'Value' => @value,
         'Timestamp' => @timestamp}.to_json
    end

    def to_s
        to_json.to_s
    end

    def self.from_json(json)
        Thing.new(json['Id'],
                  json['Value'],
                  json['Timestamp'])
    end
end
