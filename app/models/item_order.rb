class ItemOrder < ApplicationRecord
    extend FriendlyId
    friendly_id :created_at, use: :slugged

    belongs_to :product
    belongs_to :pre_order

    after_create :update_values_of_pre_order
    after_destroy :update_values_of_pre_order

    def update_values_of_pre_order
        self.pre_order.update_columns(total_general: self.pre_order.total_to_pay)
        self.pre_order.update_columns(total_commission: self.pre_order.total_of_commission_amount)
        self.pre_order.update_columns(total_without_commission: self.pre_order.total_of_real_price)
    end

end
