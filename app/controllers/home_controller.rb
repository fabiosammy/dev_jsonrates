class HomeController < ApplicationController
  def index
    # @jsonrates = Jsonrates.new
    @stocks = Stock.where(on: (Date.today - 30.days)..Date.today)
    @data_stocks = load_categories(params[:categories])
    @data_stocks.push @stocks.to_series if @data_stocks.empty?
  end

  private

  def load_categories(categories_params)
    return [] if categories_params.nil?
    data_stocks = []
    categories_params.each do |category|
      data_stocks.push @stocks.to_series(category.to_sym)
    end
    data_stocks
  end
end
