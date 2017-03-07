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

    def convert_to(to_currency)
      raise RateExchange::UnsupportedBaseCurrency.new(currency) if self.class.rates[currency].nil?
      raise RateExchange::UnsupportedCurrency.new(to_currency) if self.class.rates[currency][to_currency].nil?

      Money.new(amount * self.class.rates[currency][to_currency], to_currency)
    end


    def self.conversion_rates(base_currency, conversion_rates)
      @@rates = { base_currency => conversion_rates }
    end

    def self.rates
      @@rates
    end

  end
end
