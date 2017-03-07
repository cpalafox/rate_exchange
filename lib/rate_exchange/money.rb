module RateExchange
  class Money

    def self.conversion_rates(base_currency, conversion_rates)
      @@rates = { base_currency => conversion_rates }
    end

    def self.rates
      @@rates
    end

  end
end
