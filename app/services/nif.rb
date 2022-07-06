require "httparty"

class Nif

    attr_reader :identity_number

    def initialize(identity_number)
        @identity_number = identity_number
    end

    def call
        url = 'http://143.198.229.93:9090'

        response = HTTParty.post("#{url}/create", 

        :body => { 
            :nif => @identity_number,
        }.to_json,
            :headers => { 'Content-Type' => 'application/json' } 
        )
        return response.parsed_response
    end




end