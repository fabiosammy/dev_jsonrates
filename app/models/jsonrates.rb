class Jsonrates
  attr_accessor :action, :currencies

  def initialize(action = :live)
    @action = action
    @currencies = []
  end

  def load
    return "Don't support this action yet!" unless check_api_support
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
