require "spec_helper"

describe RateExchange::Money do
  let(:money) { RateExchange::Money.new(50, 'EUR') }

  describe '.conversion_rates' do
    it 'configures class variable' do
      RateExchange::Money.conversion_rates('EUR', {
          'USD' => 1.11,
          'Bitcoin' => 0.0047
      })

      expect(RateExchange::Money.rates).to be_a Hash
      expect(RateExchange::Money.rates).to eq({ 'EUR' => { 'USD' => 1.11, 'Bitcoin' => 0.0047 } })
    end
  end

  describe '#initialize' do
    it 'has access to amount and currency' do
      expect(money.amount).to eq(50)
      expect(money.currency).to eq('EUR')
    end
  end

  describe '#inspect' do
    it 'returns a string with the amount and currency' do
      expect(money.inspect).to eq "50.00 EUR"
    end
  end
end
