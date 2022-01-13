class Factura < ApplicationRecord
    extend FriendlyId
    friendly_id :created_at, use: :slugged

    belongs_to :user
    belongs_to :store
    belongs_to :lojista, class_name: "User"

    has_one :company, through: :store
    has_one :profile, through: :user

    has_many :itens_facturas, dependent: :destroy
    has_many :recibos, dependent: :destroy
    has_one :adc, dependent: :destroy


    def receipts
        self.recibos.order("created_at DESC")
    end

    before_create { self.reference = generate_reference }


    def generate_reference
        letter_code = "FA"
        last_code = Factura.last
    
        if (last_code.blank?)
            return "#{letter_code}00001/#{Time.now.year}"
        else
            ref = last_code.reference
            n = ref.to_s.split('')

            # Remove firsts
            n.shift
            n.shift

            #remove lasts
            n.pop
            n.pop
            n.pop
            n.pop
            n.pop

            n = n.join('').to_i
            n += 1
            return "#{letter_code}#{n.to_s.rjust(5, '0')}/#{Time.now.year}"
        end
    end

end

