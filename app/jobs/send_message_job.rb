class SendMessageJob < ApplicationJob
    queue_as :default

    def perform(message)
        count = 0

        if message.present?
            remove_spaces = message.numbers.delete(' ')
            convert_to_array = remove_spaces.split(",")
            convert_to_array.each do |cell_phone|
                SendSMS.new( message.content, cell_phone).call
                count = count + 1
            end
        end

        if message.send_to_customers
            customers = User.where(role: 0)
            customers.each do |user|
                SendSMS.new( message.content, user.cell_phone).call
                count = count + 1
            end
        end

        if message.send_to_companies
            companies = User.where(role: 1)
            companies.each do |user|
                SendSMS.new( message.content, user.cell_phone).call
                count = count + 1
            end
        end
        message.update_columns(quantity: count)
    end
end
