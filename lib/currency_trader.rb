require_relative 'currency'
require_relative 'currency_convert'

class  UnknownCurrencyCodeError < StandardError
end

# When initializing thie class, it expects one earlier CurrencyConverter object
# and one later CurrencyConverter object
# and a Currency objects.
class CurrencyTrader

  def initialize(currency_converter_earlier,currency_converter_later,my_money)
    @currency_converter_earlier = currency_converter_earlier
    @currency_converter_later = currency_converter_later
    @my_money = my_money
  end

  def best_investment
    max_money = @my_money.amount
    max_code = @my_money.code
    @currency_converter_earlier.rates.keys.each do |code|
      converted_money = @currency_converter_earlier.convert(@my_money,code)
      my_later_money = @currency_converter_later.convert(converted_money,@my_money.code)
      if my_later_money.amount > max_money
        max_money = my_later_money.amount
        max_code = converted_money.code
      end
    end
    return max_code
  end

end

