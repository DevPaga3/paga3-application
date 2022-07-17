class Profile < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    belongs_to :user, dependent: :destroy
    belongs_to :bank
    belongs_to :occupationArea
    has_many :bank_accounts, as: :accountble, dependent: :destroy
    has_many :pre_orders, dependent: :destroy
    has_many :history_of_profiles, dependent: :destroy
    has_many :moviments, dependent: :destroy
    has_many :requests, dependent: :destroy

    #has_one :bank_account, as: :accountble, dependent: :destroy
    has_one :adc, dependent: :destroy

    has_one_attached    :avatar
    has_one_attached    :work_declaration
    has_one_attached    :banking_extrato
    has_one_attached    :adc_subscribed
    attr_accessor       :inputmask

    enum genre:        { Masculino: 0, Femenino: 1 }
    enum status:        { pending: 0, active: 1, rejected: 3 }
    enum operating_sector: { Público: 0, Privado: 1 }

    
    after_create :valid_percentage
    after_update :valid_percentage, :add_purchase_amount


    def full_name
        "#{self.name} #{self.last_name}"
    end
    
    def solicitation_pending
        !self.requests.where(status: 0).any?
    end


    def bank_account
        self.bank_accounts.present? ? self.bank_accounts.first : {}
    end

    def self.search(search)
        joins(:user).where("lower(name) LIKE ? OR users.cell_phone LIKE ?", "%#{search.downcase}%", "%#{search}%")
    end



    def active_editable
        self.update_columns(can_edit: false)
    end

    def inactive_editable
        self.update_columns(can_edit: true)
    end

    def aprove
        self.update_columns(status: 1)
        msg = "Caro cliente #{name}\nA sua conta Paga3 foi activada com sucesso, já pode desfrutar dos nossos serviços de pagamento por prestações" 
        SendSMS.new( msg, self.user.cell_phone ).call
    end

    def reject
        self.update_columns(status: 3)
        msg = "Caro cliente #{name}\nLamentamos, mas a sua conta Paga3 foi rejeitada.\nPara mais informações contacta-nos em #{self.config.cell_phone} ou #{self.config.email}" 
        SendSMS.new( msg, self.user.cell_phone ).call
    end

    def valid_percentage
        self.update_columns(percentage_valid: calc_parcels)
    end

    def calc_parcels
        return 0 if self.salary <= 0

        if self.have_credit
            return (((self.salary - self.amount_credit) * self.config.effort_rate)/100)
        end
        return ((self.salary * self.config.effort_rate)/100)
    end

    def add_purchase_amount
        self.update_columns(purchase_amount: calc_parcels)
    end

    def reduce_parcels(admin_id = nil, amount_to_discount, is_credit)
        old_purchase_amount = self.purchase_amount
        amount = (self.purchase_amount - amount_to_discount.to_f)

        if self.update_columns(purchase_amount: amount) 
            if admin_id.present?
                HistoryOfProfile.create(
                    user_id: admin_id,
                    profile_id: self.id,
                    purchase_amount: old_purchase_amount,
                    amount_to_discount: amount_to_discount,
                    final_value: amount,
                    is_credit: is_credit
                )
            end
        end
    end

    def update_purchase_amount
        total_debit = self.moviments.where(is_credit: false).sum(:amount)
        total_credit = self.moviments.where(is_credit: true).sum(:amount)
        amount = total_credit - total_debit

        if self.update_columns(purchase_amount: amount)
            #Send notification SMS
        end
    end

    def self.profiles_blockeds
        Profile.joins(:user).where(users: { failed_attempts: 3 })
    end


    #============================= GENERATE SLUG =================================
    #validates :bi, uniqueness: { message: "já existe registado, deve ser unico no sistema" }



    #def name
    #    self.name.blank? ? self.user.email : self.name
    #end


    #after_update :generate_slug

    #def generate_slug
    #    new_slug = "#{self.name.parameterize}-#{create_slug}"
    #    self.update_columns(slug: new_slug)
    #end
#
    #def create_slug
    #    loop do
    #        token = SecureRandom.uuid
    #        break token unless Profile.where(slug: token).exists?
    #    end
    #end



    #validates :name,
    #    presence: {message: 'não pode estar em branco'}, 
    #    on: :update

    #validates :address, 
    #presence: {message: 'não pode estar em branco'}, 
    #on: :update
#
#
    #validate :validar_salary_amount
#
    #def validar_salary_amount
    #    errors.add(:salary, 'O valor não pode ser inferior ao salário basico') if self.salary < 10000
    #end










end
