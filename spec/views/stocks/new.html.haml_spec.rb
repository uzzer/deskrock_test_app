require 'spec_helper'

describe 'stocks/new' do
  before(:each) do
    model_stub = stub_model(Stock,
                            name: 'MyString',
                            price: '9.99',
                            quantity: 1,
                            percentage: '9.99',
                            years: 1
    )
    @stock = assign(:stock, model_stub.as_new_record)
  end

  it 'renders new stock form' do
    render

    assert_select 'form[action=?][method=?]', stocks_path, 'post' do
      assert_select 'input#stock_name[name=?]', 'stock[name]'
      assert_select 'input#stock_price[name=?]', 'stock[price]'
      assert_select 'input#stock_quantity[name=?]', 'stock[quantity]'
      assert_select 'input#stock_percentage[name=?]', 'stock[percentage]'
      assert_select 'input#stock_years[name=?]', 'stock[years]'
    end
  end
end
