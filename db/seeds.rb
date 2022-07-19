# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#   sudo service postgresql restart && eval `ssh-agent -s` && ssh-add

#   alias p_s='ssh deploy@167.71.138.70'
#   alias cap_c='cap production rails:console'
#   alias cap_logs='cap production app:logs'
# STAGING pAga2022a
#   pg_restore --verbose --clean --no-acl --no-owner -h localhost -U joaocabanga -d rails_paga3_development paga3_backup_31_08_2021.dmp

user = User.create(
    full_name: 'JM Cabanga',
    email: "manucabanga@gmail.com", 
    cell_phone: "913747200", 
    role: 222,
    password: "21Cabnaga21.",
    password_confirmation: "21Cabnaga21.",
    identity_number: "004907800KS044",
    confirmation_terms: true
)

Admin.create(
    email: user.email,
    name: "JM Cabanga", 
    cell_phone: user.cell_phone, 
    user_id: user.id, 
    role: 222
)

#host: <%= ENV.fetch("HOST_PAGA3") %>
#database: <%= ENV.fetch("DATABASE_PAGA3") %>
#port: <%= ENV.fetch("PORT_PAGA3") %>
#username: <%= ENV.fetch("USERNAME_PAGA3") %>
#password: <%= ENV.fetch("PASSWORD_PAGA3") %>


#Eliminar conta Cliente
#
#Fazer compras Online - Logista
#
#Sepração de  Digitos - Salário
#
#Sepração de  Digitos - IBAN
#
#Bloquear o Salário depois de validar a conta
#
#Ajustar o olho ao adicionar a Senha
