class MigrateProfileData < ActiveRecord::Migration[6.0]
    def change
        Profile.all.each do |profile|
            if profile.bi.present?
                response = Nif.new(profile.bi).call
                data = response['data']

                if response['success']
                    profile.bi        = data['ID_NUMBER']
                    profile.name      = data['FIRST_NAME']
                    profile.last_name = data['LAST_NAME']
                    profile.genre     = data['GENDER_NAME'] == 'MASCULINO' ? 0 : 1
                    profile.birth     = data['BIRTH_DATE']
                    profile.address   = data['RESIDENCE_NEIGHBOR']
                    profile.province  = data['RESIDENCE_PROVINCE_NAME']
                    profile.residence = data['RESIDENCE_ADDRESS']

                    profile.save

                    if profile.user.present?
                        profile.user.update_columns(confirmation_cell_phone: true)
                    end

                    p profile
                end

            end
        end
    end
end
