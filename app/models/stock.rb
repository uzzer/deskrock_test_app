# Model describing Stock object
class Stock < ActiveRecord::Base
  REQUIRED_FIELDS = %i(name price quantity percentage years)
  NUMERIC_FIELDS = %i(price quantity percentage years)

  validates(*REQUIRED_FIELDS, presence: true, allow_blank: false)
  validates(*NUMERIC_FIELDS, numericality: { greater_than: 0 })
  validates :name, length: { minimum: 2, maximum: 100 }
  validates :name, format: { with: /\A[a-z0-9_ .-]+\Z/i }

  def price_for_year(year)
    price * (1 + percentage / 100)**year  * quantity
  end

  def calculation_hash
    range = (0..years)
    range.map { |year| { year: year, stock_price: price_for_year(year) } }
  end
end
