class UserMailer < ApplicationMailer
    def welcome_email(user, password)
        @user = user
        @password  = password
        @assunto  = 'Bem vindo à Paga3'

        mail(to: @user.email, subject: 'Bem vindo à Paga3')
    end



end
