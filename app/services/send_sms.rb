class SendSMS
    include HTTParty
    attr_reader :message, :number

    def initialize(message, number)
        @message = message
        @number = number
    end

    def call
        #return Rails.env.development?
        response = HTTParty.post('https://telcosms.co.ao/send_message/', 
                :headers => {'Content-Type' => 'application/json'},
                :body => {
                    "message": {
                        "api_key_app": Rails.application.credentials.sms[:telco_sms_api_key],
                        "phone_number": @number,
                        "message_body": @message
                    }
                }.to_json
            )
    end

    def wesender
        #return Rails.env.development?
        apikey = Rails.application.credentials.sms[:wesender_api_key]
        res = HTTParty.post("https://api.wesender.co.ao/envio/apikey", 
            :headers => {'Content-Type' => 'application/json'},
            :body => {
                "ApiKey": apikey,
                "Destino": [@number],
                "Mensagem": @message,
                "CEspeciais": 'false'
            }.to_json
        )
    end


end


