require "spec_helper"
require "helpers/money_config_helper"

describe RateExchange::Money do
  let(:money) { RateExchange::Money.new(50, 'EUR') }

  describe '.conversion_rates' do
    it 'configures class variable' do
      configure_money
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

  describe '#convert_to' do
    before(:each) do
      configure_money
    end

    it 'returns a Money object' do
      expect(money.convert_to('USD')).to be_a RateExchange::Money
    end

    it 'returned money has the right values' do
      usd = money.convert_to('USD')
      expect(usd.inspect).to eq "55.50 USD"
    end

    context "with money currency not in config" do
      let(:money) { RateExchange::Money.new(50, 'MXN') }

      it 'raises exception RateExchange::UnsupportedBaseCurrency' do
        expect { money.convert_to('USD') }.to raise_error RateExchange::UnsupportedBaseCurrency
      end
    end

    context "with desired conversion not available" do
      it 'raises exception RateExchange::UnsupportedCurrency' do
        expect { money.convert_to('MXN') }.to raise_error RateExchange::UnsupportedCurrency
      end
    end
  end
end
