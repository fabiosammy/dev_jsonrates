class Stock < ApplicationRecord
  validates :on, :data, presence: true
  serialize :data, JSON

  def self.load_api(start_at = nil, end_at = Date.today)
    return nil if ENV['ENDPOINT_API_KEY'].nil?
    start_at = (end_at - 30.days) if start_at.nil?
    (start_at..end_at).each do |date|
      jsonrates = Jsonrates.new(date)
      on = jsonrates.date
      data = jsonrates.loaded_data
      stock = Stock.where(on: on).first_or_initialize
      stock.data = data
      stock.save!
    end
  end

  # Build new quotes from another currency
  def build_quotes(to, from, quotes)
    quote_usd_value_from = quotes["USD#{from}"]
    quote_usd_value_to = quotes["USD#{to}"]
    (1 / quote_usd_value_to) * (quote_usd_value_from / 1)
  end

  # Return the data series format to use in highcharts
  # Calculating from another currency != USD
  # PS: You need multiple by 1000 the timestamp, because of js format
  def self.from_currency(to, from)
    from_to = "#{from}#{to}"
    data = []
    all.each do |stock|
      new_quote = build_quote(to, from, stock.data['quotes'])
      data.push [stock.data['timestamp'] * 1000, new_quote]
    end
    return {
      name: "Comparativo de #{from} para #{to}",
      data: data
    }
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
