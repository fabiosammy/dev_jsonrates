require 'test_helper'

class JsonratesTest < ActiveSupport::TestCase
  def setup do
    @not_supported = "Don't support this action yet!"
  end

  test "don't support convert action yet" do
    jsonrates = Jsonrates.new(:convert)
    rates = jsonrates.load
    assert_equal rates, @not_supported
  end

  test "don't support timeframe action yet" do
    jsonrates = Jsonrates.new(:timeframe)
    rates = jsonrates.load
    assert_equal rates, @not_supported
  end

  test "don't support change action yet" do
    jsonrates = Jsonrates.new(:change)
    rates = jsonrates.load
    assert_equal rates, @not_supported
  end
end
