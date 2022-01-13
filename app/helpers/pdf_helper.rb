include ActionView::Helpers::NumberHelper

module PdfHelper

    def texto_de_rodape
        bounding_box([0, bounds.bottom + 15], :width => 540, :height => 30) {
            stroke_horizontal_rule
            font("Courier") do
                text "Paga a primeira e leva já - Paga3", size: 9, :valign => :bottom, :align => :center
            end
        }
    end

    def footer_imposto
        bounding_box([0, bounds.bottom + 15], :width => 540, :height => 20) {
            text "Original", size: 9, :align => :left

            stroke_horizontal_rule
            font("Courier") do
                text "imposto de selo pago por guia -dec.Lei nº18/92 DR 1ª série12/92 de 16/5/1992", size: 9, :valign => :bottom, :align => :center
            end
        }
    end

    def original_url
        request.fullpath
    end

    def format_cell_phone_number(numver)
        "+244 #{numver.scan(/.{3}|.+/).join(" ")}"
    end

    def linha
        table([[""]],
        position: 0,
        :column_widths => [540],
        :cell_style =>  {:borders => [:bottom], :padding => [0, 0, 0, 5]}) do
            row(0).border_width = 0.2
        end
    end





end

