require_relative 'currency'
class  UnknownCurrencyCodeError < StandardError
end

# When initializing thie class, it expects to receive a hash
# made up of conversion codes (in string form) as a key,
# and conversion rates as a value (as a number).
class CurrencyConvert
  attr_accessor :rates
  def initialize(rates)
    @rates = rates
  end

  def get_rate(code)
    @rates[code]
  end

  def convert(currency_obj, code_new)
    if @rates.has_key?(code_new) && @rates.has_key?(currency_obj.code)
      Currency.new((currency_obj.amount * @rates[code_new] / @rates[currency_obj.code]).round(5), code_new)
    else
      raise UnknownCurrencyCodeError
    end
  end
end



