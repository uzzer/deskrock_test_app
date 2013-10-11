# Module with support functions for stock object
# not directly related to Stock object
module StocksHelper

  def convert_calculation_to_gapi_format(data)
    header = ['Year', 'Stock price']
    data.map { |e| [e[:year].to_s , e[:stock_price].to_i] } .insert(0, header)
  end

end
