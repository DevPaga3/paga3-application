class InvoicesController < ApplicationController
    before_action :set_invoice, only: [ :details, :details_purchase, :show ]
    before_action :set_adc, only: [ :adc_details ]
    before_action :set_recibo, only: [ :recibo ]

    #load_and_authorize_resource
    
    def index
        @pagy, @invoices = pagy(Factura.all.order("created_at DESC"), items: 10)
    end

    def sales
        @invoices = current_user.company.facturas.order("created_at DESC")
    end

    def purchases
        @my_invoices = current_user.facturas.order("created_at DESC")
        @my_pending_invoices = []
    end

    def details
        
    end

    def show
        
    end

    def details_purchase
        
    end
    
    
    def adc_details
        config = @adc.config
        
        respond_to do |format|
            format.pdf do
                pdf = AdcDetails.new(@adc, config, view_context)
                send_data pdf.render, filename: "adc_#{@adc.created_at}.pdf",
                type: "application/pdf", disposition: "inline"
            end
        end
        
    end
    
    def recibo
        respond_to do |format|
            format.pdf do
                pdf = ReceiptDetails.new(@recibo, view_context)
                send_data pdf.render, filename: "recibo_#{@recibo.created_at}.pdf",
                type: "application/pdf", disposition: "inline"
            end
        end
    end

    private
        def set_invoice
            @factura = Factura.friendly.find(params[:factura_id])
        end

        def set_recibo
            @recibo = Recibo.friendly.find(params[:id])
        end

        def set_adc
            @adc = Adc.friendly.find(params[:id])
        end

end
