module RateExchange
  class Money
    module Arithmetic
      def +(other)
        raise RateExchange::WrongTypeForOperation.new(self, other, __callee__) unless other.kind_of?(Money)
        addend = other.convert_to(self.currency)
        sum = (self.amount + addend.amount).round(2)
        Money.new(sum, self.currency)
      end

      def -(other)
        raise RateExchange::WrongTypeForOperation.new(self, other, __callee__) unless other.kind_of?(Money)
        substrahend = other.convert_to(self.currency)
        difference = (self.amount - substrahend.amount).round(2)
        Money.new(difference, self.currency)
      end

      def /(divisor)
        raise RateExchange::MoneyAsDivisor if divisor.kind_of?(Money)
        quotient = (self.amount / divisor).round(2)
        Money.new(quotient, self.currency)
      end

      def *(multiplier)
        raise RateExchange::MoneyAsMultiplier if multiplier.kind_of?(Money)
        product = (self.amount * multiplier).round(2)
        Money.new(product, self.currency)
      end

      def ==(other)
        return false unless other.kind_of?(Money)
        other = other.convert_to(self.currency)
        self.inspect == other.inspect
      end

      def <(other)
        raise RateExchange::WrongTypeForOperation.new(self, other, __callee__) unless other.kind_of?(Money)
        gt = other.convert_to(self.currency)
        self.amount < gt.amount
      end

      def >(other)
        raise RateExchange::WrongTypeForOperation.new(self, other, __callee__) unless other.kind_of?(Money)
        lt = other.convert_to(self.currency)
        self.amount > lt.amount
      end
    end
  end
end
