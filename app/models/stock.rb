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

  # Build new quote from another currency
  def self.build_quote(to, from, quotes)
    quote_usd_value_from = quotes["USD#{from}"]
    quote_usd_value_to = quotes["USD#{to}"]
    (1 / quote_usd_value_to) * (quote_usd_value_from / 1)
  end

  # Return the data series format to use in highcharts
  # PS: You need multiple by 1000 the timestamp, because of js format
  def self.to_series(to = :EUR, from = :USD)
    data = []
    from_to = "USD#{to}"
    all.each do |stock|
      quote = from.to_sym == :USD ? stock.data['quotes'][from_to] :
        build_quote(to, from, stock.data['quotes'])
      data.push [stock.data['timestamp'] * 1000, quote]
    end
    return {
      name: "Comparativo de #{from} para #{to}",
      data: data
    }
  end
end
