class PurchaseCode < ApplicationRecord
  belongs_to :user

    #============================= GENERATE SLUG =================================
    #after_create :generate_code

    #def generate_code
    #    new_code = create_code
    #    self.update_columns(code: new_code)
    #end

    def finish
        self.update_columns(is_active: false)

        # Chamar uma tarefa para criar a factura em background
    end

    def self.generate_code
        loop do
            code = rand.to_s[2..5].to_i #SecureRandom.uuid
            break code unless PurchaseCode.where(code: code).exists?
        end
    end

end
