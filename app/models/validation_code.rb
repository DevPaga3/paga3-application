class ValidationCode < ApplicationRecord
    belongs_to :user

    def self.validation(user, sms_code)       
        code = ValidationCode
        .where(status: false)
        .where(cell_phone: user.cell_phone)
        .where(code: sms_code).first

        if code.present?
            code.update_columns(status: true)
            return true
        end

        return false
    end
end
