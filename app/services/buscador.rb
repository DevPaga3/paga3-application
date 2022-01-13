class Buscador
    include HTTParty
    attr_reader :bi_number

    def initialize(bi_number, kind)
        @bi_number = bi_number
        @options = { query: { type: kind, number: @bi_number } }

    end

    def call
        response = HTTParty.get('https://buscador.ao/search/document', @options)
        response.parsed_response
    end

end