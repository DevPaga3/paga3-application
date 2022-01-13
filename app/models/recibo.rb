class Recibo < ApplicationRecord
  extend FriendlyId
  friendly_id :created_at, use: :slugged
  
  belongs_to :factura
  has_one :company, through: :factura

end
