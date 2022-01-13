class Store < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  
  belongs_to :company
  belongs_to :category
  
  has_many :products, dependent: :destroy
  has_many :pre_orders, dependent: :destroy
  has_many :facturas, dependent: :destroy


  def self.all_of_request
    stores = Store.all.map{|store| store.name}
    stores << "Outro"
  end


end
