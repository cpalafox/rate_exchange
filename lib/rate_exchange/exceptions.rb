module RateExchange
  class UnsupportedCurrency < StandardError
    attr_reader :currency, :message

    def initialize(currency)
      @currency = currency
      @message = "Currency used (#{currency}) is not supported by configuration, check your conversion_rates configuration."
    end

    def to_s
      @message
    end
  end

  class UnsupportedBaseCurrency < UnsupportedCurrency
    def initialize(currency)
      super
      @message = "Base currency used (#{currency}) is not supported by configuration, check your conversion_rates configuration."
    end
  end
end
