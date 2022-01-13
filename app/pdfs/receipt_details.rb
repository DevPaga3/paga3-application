class ReceiptDetails < Prawn::Document
    include PdfHelper

    Prawn::Font::AFM.hide_m17n_warning = true

    def initialize(recibo, view)
        super(top_margin: 70)
        @company = recibo.company
        @recibo = recibo
        @view = view
    
        #referencia

        #linha
        company_logo
        info_company
        info_customer
        move_down 100

        cabecalho_da_factura
        itens_da_factura

        footer_imposto
    end

    def referencia
        bounding_box([420, cursor - 50], :width => 150, :height => 30) do
            indent(0) do
                formatted_text [{:text => "Recibo de #{@recibo.created_at.strftime("%d/%m/%Y")}", :styles => [:bold], :size =>14, :align => :right}]
            end
        end
    end

    def company_logo
        return if @company.blank?
        bounding_box([0, cursor + 30], :width => 100, :height => 100) do
            image "#{Rails.root}/public/logo.png", :position => :left, :width => 100
        end
    end

    def info_company
        return if @company.blank?
        bounding_box([0, cursor + 0], :width => 250, :height => 65) do
            text "#{@company.config.name}", size: 15, :font_style => :bold
            move_down 3
            text "Contribuinte: #{@company.config.nif}", size: 9
            move_down 3
            text "#{@company.config.address}", size: 9
            move_down 3
            text "#{@company.config.email} | #{@company.config.cell_phone}", size: 9
        end
    end

    def info_customer
        bounding_box([300, cursor + 65], :width => 240, :height => 65) do
            text "#{@recibo.factura.profile.name}", size: 12, :font_style => :bold, :align => :left
            move_down 3
            text "#{@recibo.factura.profile.bi}", size: 9, :align => :left
            move_down 3
            text "#{@recibo.factura.user.email}", size: 9, :align => :left
            move_down 3
            text "#{@recibo.factura.user.cell_phone}", size: 9, :align => :left
        end
    end

    def cabecalho_da_factura
        table([['V/Nº Contrib.', 'Data doc', 'Moeda', 'Entidade', 'Recibo Nº']],
        position: 0,
        :column_widths => [ 108, 108, 108, 150, 66],
        :cell_style =>  {:borders => [:top], :align => :left, :size => 8, :font_style => :bold, height: 18})do
            row(0).border_width = 1.3
            column(4).style(:align => :right)
        end

        table([["#{@recibo.factura.profile.bi}", "#{Time.now.strftime('%d-%m-%Y')}", 'AKZ', "#{@recibo.factura.user.cell_phone}", "#{'%.4i' % @recibo.id} /#{@recibo.created_at.strftime("%Y")}"]],
        position: 0,
        :column_widths => [ 108, 108, 108, 108, 108],
        :cell_style =>  {:borders => [], :align => :left, :size => 7, height: 30, :padding => [0, 5, 0, 5]}) do
            column(4).style(:align => :right)
        end


        table([['', '', 'Recebemos de V.exas. Para pagamento do (s) seguinte (s) documento (s)']],
        position: 0,
        :column_widths => [ 108, 108, 324],
        :cell_style =>  {:borders => [:bottom], :align => :left, :size => 8, height: 18}) do
            column(2).style(:align => :right)
        end
    end


    def itens_da_factura
        table([[
            'Documento',
            'Nº doc',
            'Nº Prest',
            'Valor documento',
            'valor amort',
            'valor pendente'
        ]],
        position: 0, :column_widths => [90, 90, 90, 90, 90, 90],
        :cell_style =>  {:borders => [], :align => :right, :size => 9,:font_style => :bold, :padding => [5, 5, 5, 5]}) do
            column(0).style(:align => :left)
            column(1).style(align: :center)
            column(2).style(align: :center)
        end

        table([[
            'FA',
            "#{@recibo.factura.reference}",
            "#{@recibo.factura.numero_parcelas}",
            "#{@recibo.factura.total_pagar.to_kwanza}",
            "#{@recibo.valor.to_kwanza}",
            "#{@recibo.factura.valor_restante.to_kwanza}"
        ]],
        position: 0, :column_widths => [90, 90, 90, 90, 90, 90],
        :cell_style =>  {:borders => [], height: 10, :padding => [0, 0, 0, 5], :align => :right, :size => 8}) do
            column(0).style(align: :left)
            column(1).style(align: :center)
            column(2).style(align: :center)
        end

        move_down 70
        linha

        referencia_do_total
    end



    def referencia_do_total

        table([['', 'Valor documento', @recibo.factura.total_pagar.to_kwanza]],
        position: 0, :column_widths => [323, 80, 120],
        :cell_style =>  {:borders => [], :align => :right, :size => 7,:font_style => :bold, :padding => [5, 0, 5, 5]}) do
            column(1).style(:align => :left)
            column(2).style(:align => :right)
        end
        
        table([['', 'valor pendente', @recibo.factura.valor_restante.to_kwanza]],
        position: 0, :column_widths => [323, 80, 120],
        :cell_style =>  {:borders => [], :align => :right, :size => 7, :padding => [5, 0, 5, 5]}) do
            column(1).style(:align => :left)
            column(2).style(:align => :right)
        end

        table([['', 'valor amort', @recibo.valor.to_kwanza]],
        position: 0, :column_widths => [323, 80, 120],
        :cell_style =>  {:borders => [], :align => :right, :size => 7, :padding => [5, 0, 5, 5]}) do
            column(1).style(:align => :left)
            column(2).style(:align => :right)
        end

        move_down 4

        table([['', 'Total recibo', @recibo.valor.to_kwanza]],
        position: 0, :column_widths => [323, 80, 120],
        :cell_style =>  {:borders => [], :align => :right, :size => 7,:font_style => :bold, :padding => [5, 0, 5, 5]}) do
            column(1).style(:align => :left, :borders => [:top])
            column(2).style(:align => :right, :borders => [:top])
        end
    end






end


