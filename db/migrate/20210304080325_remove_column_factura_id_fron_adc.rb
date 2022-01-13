class RemoveColumnFacturaIdFronAdc < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :adcs, column: "factura_id"
  end
end
