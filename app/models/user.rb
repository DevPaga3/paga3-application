class User < ApplicationRecord
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    #extend FriendlyId
    #friendly_id :email, use: :slugged

    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :authentication_keys => [:login]
    
    has_one :company, dependent: :destroy
    has_one :profile, dependent: :destroy
    has_one :admin, dependent: :destroy

    has_many :purchase_codes, dependent: :destroy
    has_many :facturas, dependent: :destroy
    has_many :history_of_profiles, dependent: :destroy
    
    after_create :create_role, :welcome_notification

    enum role: {
        admin: 222,
        operations: 10,
        finances: 12,
        comercial: 15,
        marketing: 20,
        customer: 0,
        company: 1
    }

    enum status: {
        active: 1,
        inactive: 0
    }

    validates :confirmation_terms, acceptance: true


    def create_code_validation
        return if self.any_purchase_active?

        purchase = PurchaseCode.create(
            user_id: self.id,
            code: PurchaseCode.generate_code
        )

        if purchase.present?
            msg = "Olá caro cliente,\nSeu código de validação de compra é #{purchase.code}." 
            SendSMS.new( msg, self.cell_phone ).call
        end
    end
    
    def active_for_authentication?
        super and self.is_active?
    end

    validates :email,
    presence: {message: 'não pode estar em branco'},
    format: {with: EMAIL_REGEX, message: "E-mail inválido"}


    validates :full_name,
    presence: {message: 'não pode estar em branco'}

    

    validates :cell_phone, uniqueness: true,
        presence: {message: "não pode estar em branco!"},
        :numericality => {:only_integer => true, message: "numero de telefone inválido"},
        length: {in: 9..9, message: "número de telefone inválido. Ex: 923456699"}

    def any_purchase_active?
        self.purchase_codes.where(is_active: true).exists?
    end

    def last_purchase_code
        self.purchase_codes.where(is_active: true).last
    end

    def create_role
        if self.customer?
            profile = Profile.create(user_id: self.id, name: self.full_name)
            Adc.create(profile_id: profile.id)
        end
    end

    def welcome_notification
        return unless self.customer?
        msg = "Olá caro cliente,\nSeja bemvindo a Paga3, porfavor termine de preencher o seu perfil em nossa plataforma e desfrute das vantagens." 
        SendSMS.new( msg, self.cell_phone ).call
    end

    def notification_new_user(pw)
        msg = "Olá caro Utilizador,\seu user: #{self.email}\nSua senha: #{pw}" 
        SendSMS.new( msg, self.cell_phone ).call

        content = "<h1>Seja bem vindo à Paga3</h1><p><strong>Utilizador</strong>: #{self.email}</p><p><strong>senha</strong>: #{pw}</p>"
        SendMailer.new(self.email, "BEM VINDO", content ).call
    end

    def company_id
        company.id
    end

    def profile_id
        profile.id 
    end

    def admin_id
        admin.id 
    end

    def profile_was_completed?
        is = false
        return unless self.customer?

        self.profile.attributes.each do |key, value|
            unless key == 'have_credit'
                if (value == nil || value.blank? )
                    is = true
                end
            end
        end

        return true if self.profile.salary < 15000
    
        return is
    end

    #=====================================================

    def login=(login)
        @login = login
    end

    def login
        @login || self.cell_phone || self.email
    end

    def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
          where(conditions.to_hash).where(["lower(cell_phone) = :value OR lower(email) = :value", { :value => login.downcase }]).first
        elsif conditions.has_key?(:cell_phone) || conditions.has_key?(:email)
          where(conditions.to_hash).first
        end
    end

    def inactive_user
        self.update_attribute(:is_active, false)
        msg = "Caro cliente\nA sua conta Paga3 foi desactivada por violar os nossos termos e condições, por favor contacta-nos" 
        SendSMS.new( msg, self.cell_phone ).call
    end

    def active_user
        self.update_attribute(:is_active, true)
        msg = "Caro cliente\nA sua conta Paga3 foi activada com sucesso." 
        SendSMS.new( msg, self.cell_phone ).call
    end

    def aprove_profile
        self.update_attribute(:status, 1)
        msg = "Caro cliente\nA sua conta Paga3 foi aprovada com com sucesso." 
        SendSMS.new( msg, self.cell_phone ).call
    end


end
