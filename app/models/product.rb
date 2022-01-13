class Product < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    
    belongs_to :store
    has_one_attached :image
    belongs_to :store
    has_one :company, through: :store


    after_create :generate_code, :update_values
    after_update :update_values

    def update_values
        self.update_columns(commission_amount: calc_commission_amount)
        self.update_columns(price_with_commission: calc_price_with_commission)
    end

    def calc_commission_amount
        ((self.real_price * 20)/100)
    end

    def calc_price_with_commission
        (self.real_price + calc_commission_amount)
    end

    def generate_code
        new_code = create_uniq_code
        self.update_columns(code: new_code)
    end

    def first_parcel
        (calc_price_with_commission / self.render_number.to_i)
    end

    def self.all_of_request
        products = Product.all.map{|product| product.name}
        products << "Outro"
        return products
    end

    def create_uniq_code
        letter_code = "PAGA3"
        last_code = Product.last
    
        if (last_code.blank?)
            return "#{letter_code}00001/#{Time.now.year}"
        else
            ref = last_code.code
            n = ref.to_s.split('')
            n.pop
            n.pop
            n.pop
            n.pop
            n.pop
            n.shift
            n.shift
            n.shift
            n.shift
            n.shift
            n = n.join('').to_i
            n += 1
            return "#{letter_code}#{n.to_s.rjust(5, '0')}/#{Time.now.year}"
        end
    end
end
