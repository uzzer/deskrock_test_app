require 'spec_helper'

describe 'stocks/show' do
  before(:each) do
    @stock = assign(:stock, stub_model(Stock,
      :name => 'Name',
      :price => '9.99',
      :quantity => 1,
      :percentage => '9.99',
      :years => 2
    ))
    @calculation_result = assign(:calculation_result, [{ year: 0, stock_price: 9.99 },
                                       { year: 1, stock_price: 10.99 },
                                       { year: 2, stock_price: 12.09 }])
    @max_value_show_as_long = 10**9
  end

  it 'renders attributes in <p>' do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/9.99/)
    rendered.should match(/1/)
    rendered.should match(/9.99/)
    rendered.should match(/2/)
  end
end
