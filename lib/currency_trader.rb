require_relative 'currency'
require_relative 'currency_convert'

class  UnknownCurrencyCodeError < StandardError
end

class CurrencyTrader
@currency_converter_earlier = CurrencyConvert.new( { "USD" => 1.0, "EUR" => 0.90813,"CAD" => 1.22790} )
@currency_converter_later = CurrencyConvert.new( { "USD" => 1.0, "EUR" => 0.90813,"CAD" => 1.22790} )
@my_money = currency.new(1,000,000, "USD")
