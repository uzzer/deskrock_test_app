require 'spec_helper'

describe "stocks/edit" do
  before(:each) do
    @stock = assign(:stock, stub_model(Stock,
      :name => "MyString",
      :price => "9.99",
      :quantity => 1,
      :percentage => "9.99",
      :years => 1
    ))
  end

  it "renders the edit stock form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", stock_path(@stock), "post" do
      assert_select "input#stock_name[name=?]", "stock[name]"
      assert_select "input#stock_price[name=?]", "stock[price]"
      assert_select "input#stock_quantity[name=?]", "stock[quantity]"
      assert_select "input#stock_percentage[name=?]", "stock[percentage]"
      assert_select "input#stock_years[name=?]", "stock[years]"
    end
  end
end
