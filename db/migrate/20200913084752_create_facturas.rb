class CreateFacturas < ActiveRecord::Migration[6.0]
  def change
    create_table :facturas do |t|
      t.references :user, foreign_key: true
      t.references :lojista, null: false, foreign_key: { to_table: :users }
      t.references :store, foreign_key: true

      t.decimal :total_pagar, null: false, default: 0
      t.decimal :valor_restante, null: false, default: 0
      t.integer :numero_parcelas, null: false, default: 0
      t.integer :quantidade_produtos, null: false, default: 0
      t.integer :valor_mensal_pagar, null: false, default: 0
      t.datetime :data_ultimo_pagamento
      t.string :slug

      t.timestamps
    end
  end
end

