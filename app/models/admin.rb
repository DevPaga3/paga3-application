class Admin < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    belongs_to          :user, optional: true
    has_one_attached    :avatar

    #validate :validar_cell_phone, :validar_email, on: :create

    validates :email, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false, scope: :user_id }


    validates :cell_phone, 
        presence: {message: "Não pode estar em branco!"},
        length: { maximum: 250 }, 
        uniqueness: { case_sensitive: false, scope: :user_id },
        :numericality => {:only_integer => true, message: "Número de telefone inválido"},
        length: {in: 9..9, message: "número de telefone inválido. Ex: 923456699"}



    validates :name, presence: {message: 'Não pode estar em branco'}
    validates :email, presence: {message: 'Não pode estar em branco'}
    validates :role, presence: {message: 'Não pode estar em branco'}

    def validar_email
        if User.find_by(email: self.email)
            errors.add(:email, 'E-mail indisponível')
        end
    end

    def validar_cell_phone
        if User.find_by(cell_phone: self.cell_phone)
            errors.add(:cell_phone, 'Número de telemóvel indisponível')
        end
    end

end
