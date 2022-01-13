
class AdcDetails < Prawn::Document
    include PdfHelper

    Prawn::Font::AFM.hide_m17n_warning = true

    def initialize(adc, config, view)
        super(margin: 10)

        bg_image = "#{Rails.root}/public/adc.png"
        self.image bg_image, :scale => 0.35

        font Rails.root.join("app/assets/fonts/Arial.ttf")

        @config = config
        @adc = adc
        @view = view        
        reference
        info_paga3
    end

    def info_paga3
        bounding_box([8, cursor - 47], :width => 160, height: 47) do
            text @config.address, size: 12, :align => :left
            move_down 3
            text @config.municipality, size: 12, :align => :left
            move_down 3
            text @config.province, size: 12, :align => :left
        end

        bounding_box([30, cursor + 2], :width => 130, height: 10) do
            text @config.cell_phone, size: 10, :align => :left, :valign => :bottom
        end

        bounding_box([40, cursor - 2], :width => 130, height: 10) do
            text @config.email, size: 10, :align => :left, :valign => :bottom
        end

        bounding_box([35, cursor - 16], :width => 130, height: 10) do
            text @config.nipc, size: 10, :align => :left, :valign => :bottom
        end

        bounding_box([30, cursor - 2.5], :width => 130, height: 10) do
            text @config.iec, size: 10, :align => :left, :valign => :bottom
        end

    end

    def reference
        bounding_box([230, cursor + 268], :width => 165, height: 10) do
            text @adc.reference, size: 10, :align => :left, :valign => :bottom
        end
        
        bounding_box([268, cursor - 6], :width => 250, height: 10) do
            text @adc.profile.name, size: 10, :align => :left, :valign => :bottom
        end

        bounding_box([300, cursor - 7.5], :width => 165, height: 10) do
            text @adc.profile.bi, size: 10, :align => :left, :valign => :bottom
        end 

        bounding_box([290, cursor - 7.5], :width => 200, height: 10) do
            text @adc.profile.iban, size: 10, :align => :left, :valign => :bottom
        end 

        bounding_box([290, cursor - 4], :width => 200, height: 10) do
            text @adc.profile.user.cell_phone, size: 10, :align => :left, :valign => :bottom
        end

        bounding_box([270, cursor - 7], :width => 200, height: 10) do
            text @adc.profile.user.email, size: 10, :align => :left, :valign => :bottom
        end
    end



end