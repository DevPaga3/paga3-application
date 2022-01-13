class Publicity < ApplicationRecord

    has_one_attached    :avatar

    validates :description, presence: { message: 'não pode estar em branco' }

    validates :start_date, :end_date, presence: true, if: :validate_date

    def validate_date
        errors.add(:base, "A data de início não pode ser maior ou igual à data de término.") if (start_date >= end_date)
    end

    def show_pub_on_client
        if self.status
            self.update_columns(status: false)
        else
            self.update_columns(status: true)
        end
        
    end
end
