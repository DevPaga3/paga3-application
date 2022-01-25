class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    require 'send_sms'

    EMAIL_REGEX     = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
    TELEMOVEL_REGEX = /\A[0-9]+\z/

    def config
        Configuration.first
    end

    #before_create { self.slug = generate_slug }

    def generate_slug
        SecureRandom.uuid
    end

    def self.validate_id_number(identity_number)
        nif = Nif.new(identity_number).call
        return nif['success']
    end

    
end
