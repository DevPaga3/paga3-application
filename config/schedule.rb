
# ================== TASK TO BACKUP =====================
every :day, at: '9:00 PM' do
    command "backup perform --trigger production_backup_paga3"
end