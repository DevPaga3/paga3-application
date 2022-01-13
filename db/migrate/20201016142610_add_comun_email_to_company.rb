class AddComunEmailToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :email, :string, unique: true
  end
end
