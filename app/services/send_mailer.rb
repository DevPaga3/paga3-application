class SendMailer
    require 'sendgrid-ruby'
    include SendGrid
    
    attr_reader :to, :subject, :content

    def initialize(to, subject, content)
        @content = content
        @subject = subject
        @to = to
    end

    def call
        from = Email.new(email: 'suporte@paga3.com')
        to = Email.new(email: @to)
        subject = @subject

        content = Content.new(type: 'text/html', value: @content)
        mail = Mail.new(from, subject, to, content)

        sg = SendGrid::API.new(api_key: Rails.application.credentials.sendgrid[:access_token])
        response = sg.client.mail._('send').post(request_body: mail.to_json)
    end
end
