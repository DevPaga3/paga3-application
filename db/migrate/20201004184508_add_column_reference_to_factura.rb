class AddColumnReferenceToFactura < ActiveRecord::Migration[6.0]
  def change
    add_column :facturas, :reference, :string
  end
end
