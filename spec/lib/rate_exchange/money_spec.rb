require "spec_helper"
require "helpers/money_config_helper"

describe RateExchange::Money do
  let(:money) { RateExchange::Money.new(50, 'EUR') }

  before(:each) do
    configure_money
  end

  describe '.conversion_rates' do
    it 'configures class variable' do
      expect(RateExchange::Money.rates).to be_a Hash
      expect(RateExchange::Money.rates).to eq({ 'base_currency' => 'EUR', 'USD' => 1.11, 'Bitcoin' => 0.0047 })
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
    it 'returns a Money object' do
      expect(money.convert_to('USD')).to be_a RateExchange::Money
    end

    context 'with money amount set to 0' do
      it 'returns money with new currency' do
        money = RateExchange::Money.new(0, 'EUR')
        usd_money = money.convert_to('USD')
        expect(usd_money.amount).to eq 0
        expect(usd_money.currency).to eq('USD')
      end
    end

    it 'returned money has the right values' do
      usd = money.convert_to('USD')
      expect(usd.inspect).to eq "55.50 USD"
    end

    context "when trying to convert to same currency" do
      it 'returns itself' do
        expect(money.convert_to('EUR')).to eq(money)
      end
    end
  end

  describe '#typecast' do
    context "with correct exchange currencies" do
      it 'returns a block' do
        expect(money.typecast('EUR', 'USD')).to be_a Proc
      end

      context "currency of origin is base currency in configuration" do
        it 'multiples for exchange rate' do
          typecast = money.typecast('EUR', 'USD')
          expect(typecast.call(50)).to eq((50 * 1.11).round(2))
        end
      end

      context "currency of origin isn't base currency in configuration" do
        it 'divides for exchange rate' do
          typecast = money.typecast('USD', 'EUR')
          expect(typecast.call(55.5)).to eq((55.5 / 1.11).round(2))
        end
      end
    end

    context "when using an origin currency not in configuration" do
      let(:money) { RateExchange::Money.new(50, 'MXN') }

      it 'raises exception RateExchange::UnsupportedBaseCurrency' do
        expect { money.typecast('MXN', 'USD') }.to raise_error RateExchange::UnsupportedBaseCurrency
      end
    end

    context "with desired conversion not available" do
      it 'raises exception RateExchange::UnsupportedCurrency' do
        expect { money.typecast('EUR', 'MXN') }.to raise_error RateExchange::UnsupportedCurrency
      end
    end
  end
end
