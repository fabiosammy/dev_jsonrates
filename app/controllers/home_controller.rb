class HomeController < ApplicationController
  def index
    @jsonrates = Jsonrates.new
  end
end
