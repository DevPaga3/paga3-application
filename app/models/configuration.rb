class Configuration < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    has_one_attached                :logo
    has_many :bank_accounts,        as: :accountble, dependent: :destroy

end
