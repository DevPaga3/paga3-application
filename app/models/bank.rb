class Bank < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    has_many :bank_accounts, dependent: :destroy
    has_many :profile, dependent: :destroy
end
