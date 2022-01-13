class Category < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    has_many :stores, dependent: :destroy
    has_many :companies, dependent: :destroy

end
