class RemoveDescriptionFromPartners < ActiveRecord::Migration[6.0]
  def change
    remove_column :partners, :description, :date
  end
end
