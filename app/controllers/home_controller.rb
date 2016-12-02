class HomeController < ApplicationController
  def index
    @stocks = Stock.where(on: (Date.today - 30.days)..Date.today)
    @categories = load_categories(params[:categories])
    @data_stocks = load_categories_series(@categories)
  end

  private

  def load_categories(categories_params)
    if categories_params.kind_of?(Array)
      categories_params
    elsif categories_params.nil?
      []
    else
      [categories_params]
    end
  end

  def load_categories_series(categories_params)
    data_stocks = []
    categories_params.each do |category|
      data_stocks.push @stocks.to_series(category.to_sym)
    end
    data_stocks.push @stocks.to_series if data_stocks.empty?
    data_stocks
  end
end
