class Company < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    
    belongs_to                      :user, optional: true
    belongs_to                      :category
    has_many :stores,               dependent: :destroy
    has_many :products,             through: :stores
    has_many :bank_accounts,        as: :accountble, dependent: :destroy
    has_many :facturas,             through: :stores
    has_many :recibos,              through: :facturas

    has_one_attached    :avatar

    validates :name, presence: {message: 'não pode estar em branco'}
    validates :nif, presence: {message: 'não pode estar em branco'}
    validates :address, presence: {message: 'não pode estar em branco'}
    validates :email, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false, scope: :user_id }
    validates :accountNumber, presence: {message: "não pode estar em branco!"}, uniqueness: { case_sensitive: false, scope: :user_id }
    validates :iban, presence: {message: "não pode estar em branco!"}, uniqueness: { case_sensitive: false, scope: :user_id }

    validates :cell_phone, 
        presence: {message: "não pode estar em branco!"},
        length: { maximum: 250 }, 
        uniqueness: { case_sensitive: false, scope: :user_id },
        :numericality => {:only_integer => true, message: "numero de telefone inválido"},
        length: {in: 9..9, message: "número de telefone inválido. Ex: 923456699"}

    #validate :validar_cell_phone, :validar_email, on: :create

    def self.search(search)
        where(
            "lower(name) LIKE ? OR 
            lower(cell_phone) LIKE ? OR
            lower(email) LIKE ?", 
            "%#{search.downcase}%", 
            "%#{search.downcase}%",
            "%#{search.downcase}%"
        )
    end


    def validar_email
        if User.find_by(email: self.email)
            errors.add(:email, 'E-mail não indisponível')
        end
    end

    def validar_cell_phone
        if User.find_by(cell_phone: self.cell_phone)
            errors.add(:cell_phone, 'Número de telemóvel indisponível')
        end
    end

    def reset_password
        user = self.user
        pw = rand(2**256).to_s(36).ljust(8, 'a')[0..10]

        user.password = pw
        user.password_confirmation = pw
        user.full_name = self.name
        user.save!
        msg = "Redefinição de Senha - Paga3\nUtilizador: #{user.email}\nSenha: #{pw}"
        SendSMS.new( msg, user.cell_phone).call
    end


    def create_access_user 
        
        old_user = nil
        pw = rand(2**256).to_s(36).ljust(8, 'a')[0..10]

        if self.user_id.present? #==================== Usuário existe mas não esta associado
            old_user = get_user_by_id(self.user_id)
            update_info_user(self, old_user, pw)
        else #==================== Usuário não existe, Busca pelo e-mail se existe um
            #old_user = get_user_by_email(self.email)
            user = User.create(
                full_name: self.name,
                email: self.email, 
                cell_phone: self.cell_phone, 
                confirmation_terms: true, 
                role: 1,
                identity_number: self.nif,
                password: pw, 
                password_confirmation: pw
            )
    
            self.update_columns(user_id: user.id)
            content = "<h4>Seja bem vindo à Paga3</h4><p><strong>Utilizador</strong>: #{user.email}</p><p><strong>senha</strong>: #{pw}</p>"
            SendMailer.new(user.email, "BEM VINDO", content ).call
            user.notification_new_user(pw)
            welcome_notification(user)
        end
    end

    def update_info_user(comapny, user, pw)
        comapny.update_columns(user_id: user.id)

        user.full_name = self.name
        user.password = pw
        user.password_confirmation = pw
        user.save

        user.notification_new_user(pw)
        welcome_notification(user)
    end

    def get_user_by_id(user_id)
        return User.find(user_id)
    end

    def get_user_by_email(email)
        return User.find_by(email: email)
    end

    def welcome_notification(user)
        msg = "Olá #{self.name},\nSeja bemvindo a Paga3, porfavor registe as suas lojas e produtos para estar visivel em nossa plataforma." 
        SendSMS.new( msg, user.cell_phone ).call
    end

    def show_and_hidden_in_site
        if self.show_in_site
            self.update_columns(show_in_site: false)
        else
            self.update_columns(show_in_site: true)
        end
        
    end

end
