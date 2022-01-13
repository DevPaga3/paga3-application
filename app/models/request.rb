class Request < ApplicationRecord
    belongs_to :profile

    enum status: {
        "PENDENTE": 0, 
        "REJEITADO": 1, 
        "EM_PROGRESSO": 2, 
        "APROVADO": 3, 
        "CONFIRMADO_PELO_CLIENTE": 4,
        "CANCELADO": 5
    }

    def approve_request
        self.update_columns(status: 3)
    end

    def confirmation_request(current_user)
        self.update_columns(status: 4)

        #store = Company.find_by(slug: 'loja-paga-3')

        factura = Factura.new(
            user_id: self.profile.user.id,
            lojista_id: current_user.id,
            store_id: 1,
            total_pagar: calc_price_with_commission,
            valor_restante: (calc_price_with_commission - first_parcel),
            numero_parcelas: self.render_number.to_i,
            quantidade_produtos: 1,
            valor_mensal_pagar: first_parcel,
            data_ultimo_pagamento: DateTime.now.end_of_month + (self.render_number.to_i).month
        )

        if factura.save
            recibo = Recibo.create(factura_id: factura.id, valor: first_parcel)

            Moviment.create(
                profile_id: self.profile.id, 
                user_id: current_user.id, 
                is_credit: false, 
                amount: first_parcel
            )

            self.profile.update_purchase_amount
        end
    end

    def calc_commission_amount
        ((self.price * 20)/100)
    end

    def calc_price_with_commission
        (self.price + calc_commission_amount)
    end

    def first_parcel
        (calc_price_with_commission / self.render_number.to_i)
    end
    

    
end
