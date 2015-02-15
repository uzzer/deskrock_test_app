require 'spec_helper'

describe 'stocks/show', type: :controller do
  render_views

  before(:each) do
    assign(:stock, stub_model(Stock,
                              name: 'Name',
                              price: '9.99',
                              quantity: 1,
                              percentage: '9.99',
                              years: 2
                 )
    )
    assign(:calculation_result,
           [{ year: 0,
              stock_price: 9.99
            },
            { year: 1,
              stock_price: 10.99
            },
            { year: 2,
              stock_price: 12.09
            }]
    )
    @max_value_show_as_long = 10**9
  end

  it 'renders attributes in <p>' do
    render
    # Run the generator again with the --webrat flag
    # if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
  end
end
