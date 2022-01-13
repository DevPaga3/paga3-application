class RemoveStartDateFromPartners < ActiveRecord::Migration[6.0]
  def change
    remove_column :partners, :start_date, :date
  end
end
