Given(/^The web applications runs on Heroku$/) do
  #TODO: Provide host
end

When(/^I open the application url$/) do
  visit root_path
end

Then(/^I must see the front page with application title "([^"]*)"$/) do |title|
  current_path.should == root_path
  page.should have_content(title)
end

When(/^I press button "([^"]*)"$/) do |button_text|
  click_button(button_text)
end

Then(/^I must see the page with title "([^"]*)"$/) do |title|
  page.should have_content(title)
end

When(/^I must be able to enter the following values:$/) do |table|
  # table is a | Price      | 2.00        | required decimal |
  inputs = table.rows_hash
  fill_in('stock_name', :with => inputs['Stock Name'])
  fill_in('price', :with => inputs['Price'])
  fill_in('quantity', :with => inputs['Quantity'])
  fill_in('percentage', :with => inputs['Percentage'])
  fill_in('years', :with => inputs['Years'])
end

When(/^I must see the original input data:$/) do |table|
  # table is a | Price      | 2.00        |
  inputs = table.rows_hash
  within("//li[@id='price']") do
    page.should have_content(inputs['Price'])
  end
end

When(/^list of stock values for each year:$/) do |table|
  # table is a | 1  | 412.00 |
  inputs = table.rows_hash
  inouts.each { |year_nth|
    within("//li[@year_nth='#{year_nth}']") do
      page.should have_content(inputs[year_nth])
    end
  }
end

When(/^the stock growth is shown as a visual graph$/) do
  page.should have_css('#stock_graph')
end

When(/^the stock data must be saved into the database for later review$/) do
  #TODO:  Refactoring required. Step description should not have fixed context
  #This step verifies that db has saved Stock item, but has no description which one

  #Based on fact that test usually starts with empty db it should work
  #But it is pointless testing currently
  stock = Stock.find(0)
end

When(/^I click "([^"]*)"$/) do |text|
  click(text)
end

Given(/^the web applications runs on Heroku$/) do
  #TODO: Implement Heroku details later
end

Given(/^the system has already calculated stocks$/) do |data|
  # table is a | Apple        | 172.00 | 10       | 5.00       | 10    |
  Stock.create!(data.hashes)
end

When(/^I must see a table of saved stocks:$/) do |table|
  # table is a | Apple        | 172.00 | 10       | 5.00       | 10    |
  inputs = table.rows_hash
  inputs.each {|row|
      #TODO: Implement based on view. verify that some specific row has specific data
  }
end

When(/^I click on the calculated line "([^"]*)"$/) do |text|
  within("//ul[@id='stocks']") do
    click(text)
  end

end

Then(/^I must see the already calculated data$/) do
  #TODO:  Refactoring required. Step description should not have fixed context
  # But, I know context. Let's verify.

  #TODO: Implement based on view. verify that some specific row has specific data
end
