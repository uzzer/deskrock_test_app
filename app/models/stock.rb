# Model describing Stock object
class Stock < ActiveRecord::Base

  validates :name, :price, :quantity, :percentage, :years, :presence => true
  validates_numericality_of :price, :quantity, :percentage, :years, greater_than: 0
  validates_length_of :name, :maximum => 100
  validates_length_of :name, :minimum => 2

  def price_for_year(year)
    price * (1 + percentage / 100)**year  * quantity
  end

  def get_calculation_hash
    range = (0..years)
    range.map { |year| { year: year, stock_price: price_for_year(year) } }
  end

end
