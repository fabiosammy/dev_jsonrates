class HomeController < ApplicationController
  def index
    @stocks = Stock.where(on: (Date.today - 30.days)..Date.today)
    @currency_source = params[:source].nil? ? :USD : params[:source].to_sym
    @categories = load_categories(params[:categories])
    @data_stocks = load_categories_series(@categories)
  end

  def update_stocks
    Stock.load_api
    redirect_to root_url, alert: 'Tabela de valores atualizada!'
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
      data_stocks.push @stocks.to_series(category[-3, 3].to_sym, @currency_source)
    end
    data_stocks.push @stocks.to_series(:EUR, @currency_source) if data_stocks.empty?
    data_stocks
  end
end
