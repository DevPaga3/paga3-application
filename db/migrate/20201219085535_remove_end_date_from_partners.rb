class RemoveEndDateFromPartners < ActiveRecord::Migration[6.0]
  def change
    remove_column :partners, :end_date, :date
  end
end
