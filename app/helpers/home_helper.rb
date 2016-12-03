module HomeHelper
  def load_categories_links(stocks, categories_params, currency_source = :USD)
    links = ''
    return links if stocks.first.nil?
    stocks.first.data['quotes'].keys.each do |category|
      links += "<li>"
      if categories_params.include?(category)
        links += has_category(category, categories_params, currency_source)
      else
        links += dont_has_category(category, categories_params, currency_source)
      end
      links += "</li>"
    end
    links.html_safe
  end

  private

  def has_category(category, params, source)
    new_params = params.dup
    new_params.delete(category)
    link_to category[-3, 3], root_url(categories: new_params, source: source), class: 'collection-item active'
  end

  def dont_has_category(category, params, source)
    link_to category[-3, 3], root_url(categories: params.dup.push(category), source: source), class: 'collection-item'
  end
end
