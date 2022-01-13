class PreOrder < ApplicationRecord
    extend FriendlyId
    friendly_id :created_at, use: :slugged

    
    belongs_to :profile
    belongs_to :store
    has_many :item_orders, dependent: :destroy
    has_many :products, through: :item_orders, dependent: :destroy

    def first_instalment
        (total_to_pay/largest_portion.to_i)
    end

    def largest_portion
        return 1 if self.products.blank?
        self.products.map{ |product| product.render_number }.max
    end

    #Valor a se pagar incluindo a comissão Paga3
    def total_to_pay 
        (total_of_real_price + total_of_commission_amount)
    end

    # total dos valores com as comissões
    def total_of_price_with_commission
        self.products.sum(:price_with_commission)
    end

    # Total de todas as comissões
    def total_of_commission_amount
        self.products.sum(:commission_amount)
    end

    # Total de todos os preços reais
    def total_of_real_price
        self.products.sum(:real_price)
    end


    #Criar um job para executar esta tarefa por traz

    def create_invoice(current_user)
        factura = Factura.new(
            user_id: self.profile.user.id,
            lojista_id: current_user.id,
            store_id: self.store.id,
            total_pagar: total_to_pay,
            valor_restante: total_to_pay,
            numero_parcelas: largest_portion,
            quantidade_produtos: self.products.count,
            valor_mensal_pagar: first_instalment,
            data_ultimo_pagamento: DateTime.now.end_of_month + 3.month
        )

        if factura.save
            self.products.each do |product|
                create_itens_invoice(factura, product)
            end

            #gerar o primeiro recibo que vai ser imprenso pelo lojista
            recibo = Recibo.create(factura_id: factura.id, valor: factura.valor_mensal_pagar)
            restante = (factura.valor_restante - recibo.valor)
            factura.update_columns(valor_restante: restante) if recibo.present?

            #Recalcula o valor da compra do cliente
            #value = (self.profile.purchase_amount - factura.valor_mensal_pagar)
            #self.profile.update_columns(purchase_amount: value)
            Moviment.create(
                profile_id: self.profile.id, 
                user_id: current_user.id, 
                is_credit: false, 
                amount: factura.valor_mensal_pagar
            )
            self.profile.update_purchase_amount
        end
    end

    def create_itens_invoice(factura, product)
        ItensFactura.create(
            factura_id: factura.id,
            name: product.name,
            real_price: product.real_price,
            render_number: product.render_number,
            price_with_commission: product.price_with_commission,
            commission_amount: product.commission_amount,
            code: product.code
        )
    end
    
end