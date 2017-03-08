require 'rate_exchange/money/arithmetic'

module RateExchange
  class Money
    include Money::Arithmetic
    attr_reader :amount, :currency

    def initialize(amount, currency)
      @amount = amount.to_f
      @currency = currency
    end

    def inspect
      "#{format('%.2f', amount)} #{currency}"
    end

    def convert_to(to_currency)
      return self if currency == to_currency
      typecast = typecast(currency, to_currency)
      Money.new(typecast.call(amount), to_currency)
    end

    def typecast(base_currency, to_currency)
      can_typecast?(base_currency, to_currency)
      if self.class.rates['base_currency'] == base_currency
        lambda { |amount| (amount * self.class.rates[to_currency]).round(2) }
      else
        lambda { |amount| (amount / self.class.rates[base_currency]).round(2) }
      end
    end

    def self.conversion_rates(base_currency, conversion_rates)
      @@rates = { 'base_currency' => base_currency }.merge conversion_rates
    end

    def self.rates
      @@rates
    end

    private

    def can_typecast?(base_currency, to_currency)
      raise RateExchange::UnsupportedBaseCurrency.new(base_currency) unless self.class.rates['base_currency'] == base_currency || self.class.rates.has_key?(base_currency)
      raise RateExchange::UnsupportedCurrency.new(to_currency) unless self.class.rates.has_key?(to_currency) || self.class.rates['base_currency'] == to_currency
      true
    end
  end
end
