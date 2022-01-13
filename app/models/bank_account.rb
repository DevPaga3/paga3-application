class BankAccount < ApplicationRecord
    extend FriendlyId
    friendly_id :iban, use: :slugged

    belongs_to :accountble, polymorphic: true
    belongs_to :bank

end