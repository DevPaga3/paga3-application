include ActionView::Helpers::NumberHelper
include Pagy::Frontend

module ApplicationHelper

    def calc_age(bath_date)
        DateTime.now.strftime("%Y").to_i - bath_date&.strftime("%Y").to_i || 0
    end

    def total_to_pay()
        0 #perc = self.config.percentage_in_products
    end

    def config
        Configuration.first
    end

    def version_app
        Configuration.first.version
    end

    def first_parcel
        0
    end

    Float.class_eval do
        def to_kwanza
            valor = self
            valor = 0 if valor.blank?
            number_to_currency(valor, unit: "AKz", separator: ",", delimiter:".", format: "%n %u")
        end

        def to_month
            self.to_i.to_month
        end

        def to_month_abbr
            self.to_i.to_month_abbr
        end
    end

    BigDecimal.class_eval do
        def to_kwanza
            self.to_f.to_kwanza
        end

        def to_month
            self.to_i.to_month
        end

        def to_month_abbr
            self.to_i.to_month_abbr
        end
    end

    Integer.class_eval do
        def to_kwanza
            self.to_f.to_kwanza
        end

        Integer.class_eval do
            def to_kwanza
                self.to_f.to_kwanza
            end
        end
    end


end
