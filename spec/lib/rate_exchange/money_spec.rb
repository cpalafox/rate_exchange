require "spec_helper"

describe RateExchange::Money do

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
end
