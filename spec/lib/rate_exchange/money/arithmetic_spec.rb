require "spec_helper"
require "helpers/money_config_helper"

describe RateExchange::Money do
  let(:wallet) { RateExchange::Money.new(20, 'EUR') }
  let(:bank) { RateExchange::Money.new(50, 'EUR') }

  before(:each) do
    configure_money
  end

  describe '#+' do
    let(:total) { wallet + bank }

    it 'returns a new money object' do
      expect(total).to be_a RateExchange::Money
    end

    it 'sums amounts' do
      expect(total.amount).to eq 70
    end

    context "with different currencies" do
      let(:foreign_bank) { RateExchange::Money.new(20, 'USD') }

      it 'converts second currency and sums' do
        total = bank + foreign_bank
        expect(total.inspect).to eq "68.02 EUR"
      end
    end

    context "with something other than a Money object" do
      it 'raises RateExchange::WrongTypeForOperation' do
        expect { bank + 2 }.to raise_error RateExchange::WrongTypeForOperation
      end
    end
  end

  describe '#-' do
    let(:total) { wallet - bank }

    it 'returns a new money object' do
      expect(total).to be_a RateExchange::Money
    end

    it 'substract amounts' do
      expect(total.amount).to eq -30
    end

    context "with different currencies" do
      let(:foreign_bank) { RateExchange::Money.new(20, 'USD') }

      it 'converts second currency and substract' do
        total = bank - foreign_bank
        expect(total.inspect).to eq "31.98 EUR"
      end
    end

    context "with something other than a Money object" do
      it 'raises RateExchange::WrongTypeForOperation' do
        expect { bank - 2 }.to raise_error RateExchange::WrongTypeForOperation
      end
    end
  end

  describe '#/' do
    let(:total) { wallet / 2 }

    it 'returns a new money object' do
      expect(total).to be_a RateExchange::Money
    end

    it 'divides amount' do
      expect(total.amount).to eq 10
    end

    context "with a Money object as the divisor" do
      it 'raises RateExchange::MoneyAsDivisor' do
        change = RateExchange::Money.new(2, 'EUR')
        expect { wallet / change }.to raise_error RateExchange::MoneyAsDivisor
      end
    end
  end

  describe '#*' do
    let(:total) { wallet * 2 }

    it 'returns a new money object' do
      expect(total).to be_a RateExchange::Money
    end

    it 'multiples amount' do
      expect(total.amount).to eq 40
    end

    context "with a Money object as the multiplier" do
      it 'raises RateExchange::MoneyAsMultiplier' do
        change = RateExchange::Money.new(2, 'EUR')
        expect { wallet * change }.to raise_error RateExchange::MoneyAsMultiplier
      end
    end
  end

  describe '#==' do
    context "with money objects with same currency" do
      context "with same amounts" do
        it 'returns true' do
          twenty_eur = RateExchange::Money.new(20, 'EUR')
          expect(wallet == twenty_eur).to be true
        end
      end

      context "with different amounts" do
        it 'returns false' do
          ten_eur = RateExchange::Money.new(10, 'EUR')
          expect(wallet == ten_eur).to be false
        end
      end
    end

    context "with money objects with different currency" do
      context "with equivalent amounts" do
        it 'returns true' do
          dollars = RateExchange::Money.new(55.5, 'USD')
          expect(bank == dollars).to be true
        end
      end

      context "with different equivalent amounts" do
        it 'returns false' do
          dollars = RateExchange::Money.new(50, 'USD')
          expect(bank == dollars).to be false
        end
      end
    end

    context "with something other than a money object" do
      it 'returns false' do
        expect(wallet == 2).to be false
      end
    end
  end

  describe '#<' do
    context "with money objects with same currency" do
      context "when it's less than" do
        it 'returns true' do
          euros = RateExchange::Money.new(30, 'EUR')
          expect(wallet < euros).to be true
        end
      end

      context "when it's greater than" do
        it 'returns false' do
          euros = RateExchange::Money.new(10, 'EUR')
          expect(wallet < euros).to be false
        end
      end
    end

    context "with money objects with different currency" do
      context "when it's less than with equivalent amounts" do
        it 'returns true' do
          dollars = RateExchange::Money.new(55.5, 'USD')
          expect(wallet < dollars).to be true
        end
      end

      context "when it's greater than with equivalent amounts" do
        it 'returns false' do
          dollars = RateExchange::Money.new(50, 'USD')
          expect(bank < dollars).to be false
        end
      end
    end

    context "with something other than a Money object" do
      it 'raises RateExchange::WrongTypeForOperation' do
        expect { bank < 2 }.to raise_error RateExchange::WrongTypeForOperation
      end
    end
  end

  describe '#>' do
    context "with money objects with same currency" do
      context "when it's greater than" do
        it 'returns true' do
          euros = RateExchange::Money.new(30, 'EUR')
          expect(bank > euros).to be true
        end
      end

      context "when it's less than" do
        it 'returns false' do
          euros = RateExchange::Money.new(30, 'EUR')
          expect(wallet > euros).to be false
        end
      end
    end

    context "with money objects with different currency" do
      context "when it's greater than with equivalent amounts" do
        it 'returns true' do
          dollars = RateExchange::Money.new(50, 'USD')
          expect(bank > dollars).to be true
        end
      end

      context "when it's less than with equivalent amounts" do
        it 'returns false' do
          dollars = RateExchange::Money.new(60, 'USD')
          expect(bank > dollars).to be false
        end
      end
    end

    context "with something other than a Money object" do
      it 'raises RateExchange::WrongTypeForOperation' do
        expect { bank > 2 }.to raise_error RateExchange::WrongTypeForOperation
      end
    end
  end
end
