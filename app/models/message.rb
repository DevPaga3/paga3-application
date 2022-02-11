class Message < ApplicationRecord

    validates :content, presence: {message: 'Não pode estar em branco'}, length: { maximum: 150 }

    def send_message
        SendMessageJob.perform_later(self)
    end

end
