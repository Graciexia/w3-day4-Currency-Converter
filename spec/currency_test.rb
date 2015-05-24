require "minitest/autorun"
require_relative '../lib/currency'

class CurrencyTest < Minitest::Test

  def test_currency_exists
    assert(Currency)
  end

  def test_currency_has_amount_code
    test_10_dollars = Currency.new(10,"USD")
    assert_equal(10, test_10_dollars.amount)
    assert_equal("USD", test_10_dollars.code)
  end

  def test_currency_other_same_amount_and_code
    test_10_dollars = Currency.new(10,"USD")
    test_other_10_dollars = Currency.new(10,"USD")
    assert_equal(test_other_10_dollars, test_10_dollars)
  end

  def test_currency_other_differnet_amount_and_code
    test_10_dollars = Currency.new(10,"USD")
    test_11_dollars = Currency.new(11,"USD")
    refute_equal(test_10_dollars, test_11_dollars)
  end

  def test_currency_add_same_code
    test_10_dollars = Currency.new(10,"USD")
    test_11_dollars = Currency.new(11,"USD")
    assert_equal(21, test_10_dollars + test_11_dollars)
  end

  def test_currency_subtract_same_code
    test_10_dollars = Currency.new(10,"USD")
    test_11_dollars = Currency.new(11,"USD")
    assert_equal(1, test_11_dollars.amount - test_10_dollars.amount)
  end

  def test_currency_add_other_code
    assert_raises(DifferentCurrencyCodeError) do
      Currency.new(10,"USD") + Currency.new(11,"EUR")
    end
  end

  def test_currency_subtract_other_code
    assert_raises(DifferentCurrencyCodeError) do
      Currency.new(10,"USD") - Currency.new(11,"EUR")
    end
  end

  def test_multiply_against_fixnum
    assert_equal(Currency.new(50,"USD"), Currency.new(10,"USD") * 5)
    assert_equal(Currency.new(5,"USD"), Currency.new(1,"USD") * 5)
    assert_equal(Currency.new(3,"USD"), Currency.new(1,"USD") * 3.0)
    assert_equal(Currency.new(10.0,"USD"), Currency.new(3,"USD") * 3.33333333333)
    assert_equal(Currency.new(3.33333,"USD"), Currency.new(2,"USD") * 1.66666666667)
  end

end
