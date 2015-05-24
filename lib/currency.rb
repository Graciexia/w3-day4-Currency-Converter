class DifferentCurrencyCodeError < StandardError
end

class InvalidMultiplierTypeError < StandardError
end

class Currency
  attr_accessor :amount, :code
  def initialize(amount, code)
    @amount = amount
    @code = code
  end

  def ==(other)
    return other.is_a?(Currency) && @amount == other.amount && @code == other.code
  end

  def +(other)
    if other.is_a?(Currency) && other.code == code
      @amount += other.amount
    else
     raise DifferentCurrencyCodeError
    end
  end

  def -(other)
     if other.is_a?(Currency) && other.code == code
      @amount -= other.amount
    else
     raise  DifferentCurrencyCodeError
    end
  end

 # Currency.new(10, "USD") * 5 == Currency.new(50, "USD")
  def *(other)
    if other.is_a?(Fixnum) || other.is_a?(Float)
      return_object = Currency.new((@amount * other), code)
      if return_object.amount.is_a?(Float)
        return_object.amount = return_object.amount.round(5)
      end
      return return_object
    else
      raise
    end
  end

end
