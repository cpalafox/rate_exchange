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

  class MoneyAsDivisor < StandardError
    def to_s
      "You can't use a Money object as a divisor"
    end
  end

  class MoneyAsMultiplier < StandardError
    def to_s
      "You can't use a Money object as a multiplier"
    end
  end

  class WrongTypeForOperation < StandardError
    attr_reader :object, :parameter, :method, :message
    def initialize(object, parameter, method)
      @object = @object
      @parameter = parameter
      @method = method
      @message = "You can't use (#{parameter}) for #{object.class.name}##{method} method"
    end

    def to_s
      @message
    end
  end
end
