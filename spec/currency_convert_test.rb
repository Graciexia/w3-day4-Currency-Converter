require "minitest/autorun"
require_relative '../lib/currency_convert'
require_relative '../lib/currency'

class CurrencyConvertTest < Minitest::Test

  def test_currency_convert_exists
    assert(CurrencyConvert)
  end

  def test_currency_convert_has_hash
    currency_converter = CurrencyConvert.new( { "EUR" => 0.90813 } )
    assert(currency_converter.rates).instance_of? (Hash)
    assert_equal(0.90813, currency_converter.rates["EUR"])
  end

  def test_currency_get_rate_by_code
    currency_converter = CurrencyConvert.new( { "USD" => 1.0, "EUR" => 0.90813 } )
    assert_equal(1.0, currency_converter.get_rate("USD"))
    assert_equal(0.90813, currency_converter.get_rate("EUR"))
  end

  def test_convert_simple_conversion
    currency_converter_earlier = CurrencyConvert.new( { "USD" => 1.0, "EUR" => 0.90813,"CAD" => 1.22790} )
    currency_converter_later = CurrencyConvert.new( { "USD" => 1.0, "EUR" => 0.91813,"CAD" => 1.20790} )
    my_money = Current.new*(1000000,"USD")
    test_10_usd = Currency.new(10,"USD")
    assert_equal(Currency.new(9.0813, "EUR"), currency_converter.convert(test_10_usd, "EUR"))
    assert_equal(Currency.new(12.2790, "CAD"), currency_converter.convert(test_10_usd, "CAD"))
  end

  def test_convert_all_codes_conversion
    currency_converter = CurrencyConvert.new( { "USD" => 1.0, "EUR" => 0.90813,"CAD" => 1.22790} )
    test_10_cad = Currency.new(10,"CAD")
    test_10_euro = Currency.new(10,"EUR")
    assert_equal(Currency.new(7.39580, "EUR"), currency_converter.convert(test_10_cad, "EUR"))
    assert_equal(Currency.new(8.14399, "USD"), currency_converter.convert(test_10_cad, "USD"))
    assert_equal(Currency.new(11.01164, "USD"), currency_converter.convert(test_10_euro, "USD"))
    assert_equal(Currency.new(13.52119, "CAD"), currency_converter.convert(test_10_euro, "CAD"))
  end

  def test_convert_unknown_rate
    currency_converter = CurrencyConvert.new( { "USD" => 1.0, "EUR" => 0.90813,"CAD" => 1.22790} )
    test_10_xyz = Currency.new(10,"XYZ")
    test_10_usd = Currency.new(10,"USD")
    assert_raises(UnknownCurrencyCodeError) do
      currency_converter.convert(test_10_xyz, "CAD")
    end
    assert_raises(UnknownCurrencyCodeError) do
      currency_converter.convert(test_10_usd, "XYZ")
    end
  end

end


