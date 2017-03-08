require "spec_helper"

describe RateExchange::UnsupportedCurrency do
  describe 'when raised' do
    it 'gives explanation' do
      exception = RateExchange::UnsupportedCurrency.new('EUR')
      expect(exception.currency).to eq 'EUR'
      expect(exception.to_s).to eq "Currency used (EUR) is not supported by configuration, check your conversion_rates configuration."
    end
  end
end

describe RateExchange::UnsupportedBaseCurrency do
  describe 'when raised' do
    it 'gives explanation' do
      exception = RateExchange::UnsupportedBaseCurrency.new('EUR')
      expect(exception.currency).to eq 'EUR'
      expect(exception.to_s).to eq "Base currency used (EUR) is not supported by configuration, check your conversion_rates configuration."
    end
  end
end

describe RateExchange::MoneyAsDivisor do
  describe 'when raised' do
    it 'gives explanation' do
      exception = RateExchange::MoneyAsDivisor.new()
      expect(exception.to_s).to eq "You can't use a Money object as a divisor"
    end
  end
end

describe RateExchange::MoneyAsMultiplier do
  describe 'when raised' do
    it 'gives explanation' do
      exception = RateExchange::MoneyAsMultiplier.new()
      expect(exception.to_s).to eq "You can't use a Money object as a multiplier"
    end
  end
end

describe RateExchange::WrongTypeForOperation do
  describe 'when raised' do
    it 'gives explanation' do
      exception = RateExchange::WrongTypeForOperation.new(RateExchange::Money.new(2, 'EUR'), 2, :+)
      expect(exception.to_s).to eq "You can't use (2) for RateExchange::Money#+ method"
    end
  end
end
