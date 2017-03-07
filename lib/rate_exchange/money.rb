module RateExchange
  class Money
    attr_reader :amount, :currency

    def initialize(amount, currency)
      @amount = amount
      @currency = currency
    end

    def inspect
      "#{format('%.2f', amount)} #{currency}"
    end

    def self.conversion_rates(base_currency, conversion_rates)
      @@rates = { base_currency => conversion_rates }
    end

    def self.rates
      @@rates
    end

  end
end
