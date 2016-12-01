require 'open-uri'
require 'json'

class Jsonrates
  ENDPOINT_API = 'http://apilayer.net/api/'
  ACCESS_KEY = "access_key=#{ENV['ENDPOINT_API_KEY']}"

  attr_accessor :action, :currencies

  def initialize(action = :live)
    @action = action
    @currencies = []
  end

  def load
    return "Don't support this action yet!" unless check_api_support
    stream = open(url_with_access_key)
    JSON.parse(stream.read)
  end

  def build_url
    url = "#{ENDPOINT_API}#{@action}?"
    url += "&date=#{@date.strftime("%Y-%M-%D")}" if @action == :historical
    url += "&currencies=#{@currencies.join(',')}" unless @currencies.empty?
    return url
  end

  def persisted?
    false
  end

  def url_with_access_key
    "#{build_url}&#{ACCESS_KEY}"
  end

  private

  def check_api_support
    case @action
    when :live, :historical
      true
    else
      false
    end
  end
end
