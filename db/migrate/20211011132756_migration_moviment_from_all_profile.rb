class MigrationMovimentFromAllProfile < ActiveRecord::Migration[6.0]
  def change
    Profile.all.each do |profile|
      Moviment.create(
        profile_id: profile.id, 
        user_id: 1,
        is_credit: true, 
        amount: profile.purchase_amount
      )
      
      profile.update_purchase_amount
    end
  end
end
