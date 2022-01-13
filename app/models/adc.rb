class Adc < ApplicationRecord
  extend FriendlyId
  friendly_id :created_at, use: :slugged
  
  belongs_to :factura
  belongs_to :profile

  before_create { self.reference = generate_reference }

  def generate_reference
    letter_code = "ADC"
    last_code = Adc.last

    if (last_code.blank?)
        return "#{letter_code}00001/#{Time.now.year}"
    else
        ref = last_code.reference
        n = ref.to_s.split('')

        # Remove firsts
        n.shift
        n.shift
        n.shift

        #remove lasts
        n.pop
        n.pop
        n.pop
        n.pop
        n.pop

        n = n.join('').to_i
        n += 1
        return "#{letter_code}#{n.to_s.rjust(5, '0')}/#{Time.now.year}"
    end
  end


end
