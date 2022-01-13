class OccupationArea < ApplicationRecord
    
    has_many :profile, dependent: :destroy
end
