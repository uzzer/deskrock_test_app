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

  def result_for_chartjs
    hash = calculation_hash
    { values: stock_values(hash), labels: stock_labels(hash) }
  end

  private

  def stock_labels(hash)
    "[#{ hash.map { |e| e[:year] }.join(', ')}]"
  end

  def stock_values(hash)
    "[#{hash.map { |e| e[:stock_price].round(2).to_s }.join(', ')}]"
  end


end
