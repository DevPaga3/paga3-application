class CreateMessages < ActiveRecord::Migration[6.0]
  def change

    if !table_exists? :messages
      create_table :messages do |t|
        t.string :content
        t.integer :quantity, null: false, default: 0
        t.boolean :send_to_companies, null: false, default: false
        t.boolean :send_to_customers, null: false, default: false

        t.timestamps
      end
    end
  end
end
