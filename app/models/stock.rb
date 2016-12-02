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

  # Return the data series format to use in highcharts
  # PS: You need multiple by 1000 the timestamp, because of js format
  def self.from_USD(to)
    from_to = "USD#{to}"
    data = []
    all.each do |stock|
      data.push [stock.data['timestamp'] * 1000, stock.data['quotes'][from_to]]
    end
    return {
      name: "Comparativo de USD para #{to}",
      data: data,
    }
  end

  def self.to_series(to = :EUR, from = :USD)
    return nil if from != :USD
    return from_USD(to)
  end
end
