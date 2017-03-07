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
