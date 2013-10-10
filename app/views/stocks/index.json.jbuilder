json.array!(@stocks) do |stock|
  json.extract! stock, :name, :price, :quantity, :percentage, :years
  json.url stock_url(stock, format: :json)
end
