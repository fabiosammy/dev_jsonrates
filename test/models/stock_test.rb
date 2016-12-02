require 'test_helper'

class StockTest < ActiveSupport::TestCase
  test "load_api create a Stock today" do
    assert_difference 'Stock.count' do
      Stock.load_api(Date.today)
    end
  end
end
