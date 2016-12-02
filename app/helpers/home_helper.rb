module HomeHelper
  def load_categories_links(stocks, categories_params)
    links = ''
    stocks.first.data['quotes'].keys.each do |category|
      links += "<li>"
      if categories_params.include?(category)
        links += has_category(category, categories_params)
      else
        links += dont_has_category(category, categories_params)
      end
      links += "</li>"
    end
    links.html_safe
  end

  private

  def has_category(category, params)
    link_to category, root_url(categories: params.dup.delete(category)), class: 'collection-item active'
  end

  def dont_has_category(category, params)
    link_to category, root_url(categories: params.dup.push(category)), class: 'collection-item'
  end
end
