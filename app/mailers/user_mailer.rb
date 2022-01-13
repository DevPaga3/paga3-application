class UserMailer < ApplicationMailer
    def welcome_email(user, password)
        @user = user
        @password  = password
        @assunto  = 'Bem vindo à Paga3'

        mail(to: @user.email, subject: 'Paga3 seja bemvindo')
    end



end
