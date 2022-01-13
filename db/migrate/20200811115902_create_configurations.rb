class CreateConfigurations < ActiveRecord::Migration[6.0]
  def change
    create_table :configurations do |t|
      t.string :name
      t.string :cell_phone
      t.string :email
      t.string :address
      t.string :nif
      t.string :slug
      t.integer :percentage_in_products

      t.timestamps
    end

    Configuration.create(name: 'Paga3 Soluções', cell_phone: '923999000', email: 'geral@paga3.com', address: 'Kinaxixi, Luanda', nif: '5809119089', percentage_in_products: 10)
  end
end
