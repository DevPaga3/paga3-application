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




#NAO FEITO
#===========================================================================

#Atualizar os dados não estão a ser feitos. Quando o utilizador edita um campo, o mesmo campo não esta a ser atualizado
#Não me permite fazer um update(atualização) da palavra passe. Para uma Palavra passe que o usuário se sinta mais confortável ou que seja mais fácil de lembrar
#Imagens não estão bem centralizadas isso faz com que a pagina não seja visível
#Imagens não estão a ser bem Ajustadas

#===========================================================================
#===========================================================================
#
#PROGRESSO
#===========================================================================
#Botão eliminar não esta a funcionar em algumas páginas
#
#===========================================================================
#===========================================================================

# HOJE
# O botão resetar palavra passe e associar clientes tem a mesma função
# Botão limpar, deve ter o mesmo formato que limpar e estar bem enquadrado
# Adicionar botão para Editar área de atuação. Ou permite deletar
# Alguns botões de eliminar nos levam em uma pagina de erro
# Os campos precisam ser validados ao adicionar utilizador ou qualquer uma outra coisa
    # Validação do E-mail
    # Validação do Numero de conta (Only Number)
    # Validação do Numero de telefone

#===========================================================================
#
#FEITO
#===========================================================================
#Mostrar mensagem de erro quando o utilizador coloca password errada
#O botão de informação que notifica quando o user faz o login com sucesso ou qualquer uma outra coisa com sucesso não esta a ser removido automaticamente e nem permite a sua remoção ao menos que o utilizador mude de página ou faça o refresh(atualização) da pagina
#Adicionar uma pagina onde ficara os users bloqueados e adicionar um botão de rejeitar
#O olho que permite o utilizador ver se adicionou devidamente a palavra passe, no inicio aparece habilitado mas não permite o utilizador ver a palavra passe, só depois de vários cliques
#Quando criamos uma empresa não nos permite fazer login com as credenciais
#