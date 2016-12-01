require 'test_helper'

class JsonratesTest < ActiveSupport::TestCase
  def setup
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

  test "Jsonrates isn't persisted" do
    jsonrates = Jsonrates.new
    assert_equal jsonrates.persisted?, false
  end

  test "build url to default live action" do
    jsonrates = Jsonrates.new
    assert_equal jsonrates.build_url, "http://apilayer.net/api/live/?"
  end
end
