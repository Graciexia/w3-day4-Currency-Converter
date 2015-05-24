require "minitest/autorun"
require_relative '../lib/currency_convert'
require_relative '../lib/currency'
require_relative '../lib/currency_trader'

class CurrencyTraderTest < Minitest::Test

  def test_currency_trader_exists
    assert(CurrencyTrader)
  end

  def test_currency_trader_best_investment
    test_currency_trader = CurrencyTrader.new(
      CurrencyConvert.new( { "USD" => 1.0, "EUR" => 0.90813,"CAD" => 1.22790} ),
      CurrencyConvert.new( { "USD" => 1.0, "EUR" => 0.94876,"CAD" => 1.10000} ),
      Currency.new(100, "USD"))
    assert_equal("CAD", test_currency_trader.best_investment)
  end
end
