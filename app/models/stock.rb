class Stock < ApplicationRecord
  validates :on, :data, presence: true
  serialize :data, JSON

  def self.load_api(start_at = nil, end_at = Date.today)
    start_at = end_at - 30.days if start_at.nil?
    (start_at..end_at).each do |date|
      jsonrates = Jsonrates.new(date)
      on = jsonrates.date
      data = jsonrates.loaded_data
      stock = Stock.first_or_initialize on: on
      stock.data = data
      stock.save!
    end
  end
end
