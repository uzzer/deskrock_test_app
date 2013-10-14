# Module with support functions for stock object
# not directly related to Stock object
module StocksHelper

  def convert_calculation_to_gapi_format(data)
    header = ['Year', 'Stock price']
    data.map { |e| [e[:year].to_s , e[:stock_price].to_i] } .insert(0, header)
  end

  def convert_calculation_numbers_only(data)
    data.map { |e| e[:stock_price].round(2).to_s }
  end

  def convert_calculation_labels_only(data)
    data.map { |e| e[:year].round(2).to_s }
  end

end
