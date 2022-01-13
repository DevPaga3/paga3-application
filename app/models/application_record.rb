class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    require 'send_sms'

    EMAIL_REGEX     = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
    TELEMOVEL_REGEX = /\A[0-9]+\z/
    NOME_REGEX      = /\A[a-zA-Z0-90\W\w\s\-]*$\z/i

    def config
        Configuration.first
    end

    
end
