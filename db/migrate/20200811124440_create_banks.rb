class CreateBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :sigla
      t.string :account
      t.string :iban
      t.boolean :status, null: false, default: true
      t.references :configuration, null: true, foreign_key: true, default: Configuration.first

      t.timestamps
    end
  end
end
