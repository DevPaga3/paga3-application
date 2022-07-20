class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    require 'send_sms'

    EMAIL_REGEX     = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
    CELLPHONE_REGEX = /\A[0-9]+\z/
    PASSWORD_REGEX  = /\A^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$\z/

    VALID_EMAIL_REGEX= /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

    
    def config
        Configuration.first
    end

    #before_create { self.slug = generate_slug }

    def generate_slug
        SecureRandom.uuid
    end



    
end
