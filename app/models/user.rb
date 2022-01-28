class User < ApplicationRecord
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    #extend FriendlyId
    #friendly_id :email, use: :slugged

    attr_accessor :identity_number

    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :authentication_keys => [:login]
    
    has_one :company, dependent: :destroy
    has_one :profile, dependent: :destroy
    has_one :admin, dependent: :destroy

    has_many :purchase_codes, dependent: :destroy
    has_many :facturas, dependent: :destroy
    has_many :history_of_profiles, dependent: :destroy
    
    after_create :send_code_validation
    after_create :create_customer

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

    validates :email, presence: {message: 'Não pode estar em branco'}, format: {with: EMAIL_REGEX, message: "E-mail inválido"}

    validates :password, 
    presence: {message: 'Não pode estar em branco'}
    #format: {with: PASSWORD_REGEX, message: "A senha deve conter duas letras maiúscula, um caracter especial, dois digitos e três letras minúsculas."}

    validates :cell_phone, uniqueness: true,
        presence: {message: "Não pode estar em branco!"},
        :numericality => {:only_integer => true, message: "Número de telefone inválido"}


    validates :confirmation_terms, acceptance: true

    validates :identity_number, presence: {message: "Não pode estar em branco!"}
    validate :validate_identity_number, on: :create

    def send_code_validation
        code = generate_sms_code

        msg = "PAGA3\nOlá caro cliente,\nSeu código de validação de conta PAGA3 é\n\n#{code}"
        SendSMS.new( msg, self.cell_phone).call

        ValidationCode.create(
            code: code,
            cell_phone: self.cell_phone,
            user_id: self.id
        )
    end

    def generate_sms_code
        loop do
            code = srand.to_s.last(4) # rand.to_s[2..5].to_i
            break code unless ValidationCode.where(code: code).exists?
        end
    end


    def validate_id_number?
        nif = Nif.new(self.identity_number).call
        return nif['success']
    end

    def validate_identity_number
        if self.customer?
            if Profile.find_by(bi: self.identity_number)
                errors.add(:identity_number, 'Indisponível')
            end

            unless validate_id_number?
                errors.add(:identity_number, 'Inválido')
            end
        end
    end

    def update_confirmation_cell_phone
        self.update_columns(confirmation_cell_phone: true)
    end

    def create_customer
        if self.customer?
            response = Nif.new(self.identity_number).call
            data = response['data']

            profile = Profile.create(
                user_id:   self.id, 
                bi:        data['ID_NUMBER'],
                name:      data['FIRST_NAME'],
                last_name: data['LAST_NAME'],
                genre:     data['GENDER_NAME'] == 'MASCULINO' ? 0 : 1 ,
                birth:     data['BIRTH_DATE'],
                address:   data['RESIDENCE_NEIGHBOR'],
                province:  data['RESIDENCE_PROVINCE_NAME'],
                residence: data['RESIDENCE_ADDRESS']
            )
            
            Adc.create(profile_id: profile.id)
        end
    end

    def cell_phone_is_valide

    end




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

    def any_purchase_active?
        self.purchase_codes.where(is_active: true).exists?
    end

    def last_purchase_code
        self.purchase_codes.where(is_active: true).last
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
