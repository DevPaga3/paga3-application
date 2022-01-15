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
    email: "manucabanga@gmail.com", 
    cell_phone: "913747200", 
    role: 222,
    password: "q1w2e3r4",
    password_confirmation: "q1w2e3r4",
    confirmation_terms: true
)

Admin.create(
    email: user.email,
    name: "JM Cabanga", 
    cell_phone: user.cell_phone, 
    user_id: user.id, 
    role: 222
)

p user
