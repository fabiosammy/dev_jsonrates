class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_last_stock

  private

  def get_last_stock
    @stock = Stock.order(updated_at: :desc).first
  end
end
