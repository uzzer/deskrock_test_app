# Model describing Stock object
class Stock < ActiveRecord::Base
  def price_for_year(year)
    price * (1 + percentage / 100)**year  * quantity
  end

  def get_calculation_hash
    range = (0..years)
    range.map { |year| { year: year, stock_price: price_for_year(year) } }
  end

end
