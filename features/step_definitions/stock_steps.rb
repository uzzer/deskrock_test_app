Given(/^[tT]he web applications runs on Heroku$/) do
  # TODO: Ask it it required to make tests dependant from host.
end

When(/^I open the application url$/) do
  visit root_path
end

Then(/^I must see the front page with application title "([^"]*)"$/) do |title|
  expect(current_path).to eq(root_path)
  expect(page).to have_content(title)
end

When(/^I press button "([^"]*)"$/) do |button_text|
  click_button(button_text)
end

Then(/^I must see the page with title "([^"]*)"$/) do |title|
  expect(page).to have_content(title)
end

When(/^I must be able to enter the following values:$/) do |table|
  # table is a | Price      | 2.00        | required decimal |
  inputs = table.raw.map { |e| { e[0] => e[1] } }.reduce Hash.new, :merge
  fill_in('stock_name', with: inputs['Stock name'])
  fill_in('stock_price', with: inputs['Price'])
  fill_in('stock_quantity', with: inputs['Quantity'])
  fill_in('stock_percentage', with: inputs['Percentage'])
  fill_in('stock_years', with: inputs['Years'])
end

When(/^I must see the original input data:$/) do |table|
  # table is a | Price      | 2.00        |
  inputs = table.rows_hash
  within("//p[@id='name']") do
    expect(page).to have_content(inputs['Stock Name'])
  end
  within("//p[@id='price']") do
    expect(page).to have_content(inputs['Price'])
  end
  within("//p[@id='quantity']") do
    expect(page).to have_content(inputs['Quantity'])
  end
  within("//p[@id='percentage']") do
    expect(page).to have_content(inputs['Percentage'])
  end
  within("//p[@id='years']") do
    expect(page).to have_content(inputs['Years'])
  end
end

When(/^list of stock values for each year:$/) do |table|
  # table is a | 1  | 412.00 |
  inputs = table.rows_hash
  inputs.each do |year_nth, _|
    within("//tr[@data-year='#{year_nth}']") do
      expect(page).to have_content(inputs[year_nth])
    end
  end
end

When(/^the stock growth is shown as a visual graph$/) do
  expect(page).to have_css('#stock_graph')
end

When(/^the stock data must be saved into the database for later review$/) do
  # TODO:  Refactoring required. Step description context dependant
  # This step verifies that db has saved Stock item,
  # but has no description which one

  # Based on fact that db has created previously stock with quantity 400.
  # This theory makes test seek.
  Stock.find_by_quantity(400)
end

When(/^I click "([^"]*)"$/) do |text|
  click_link(text)
end

Given(/^the system has already calculated stocks$/) do |data|
  # table is a | Apple        | 172.00 | 10       | 5.00       | 10    |
  # noinspection RubyStringKeysInHashInspection
  mappings =
      {
        'Name' => 'name',
        'Quantity' => 'quantity',
        'Price' => 'price',
        'Percentage' => 'percentage',
        'Years' => 'years'
      }
  # rubocop:disable Style/EmptyLiteral
  data = data.hashes.map do |h|
    h.map { |k, v| { mappings[k] => v } }.reduce Hash.new, :merge
  end
  # rubocop:enable Style/EmptyLiteral
  data.each { |d| Stock.create!(d) }
end

When(/^I must see a table of saved stocks:$/) do |table|
  # table is a | Apple        | 172.00 | 10       | 5.00       | 10    |
  inputs = table.hashes
  inputs.each do |row|
    row = find('tr', text: row['Name'])
    expect(row).to have_content(row['Price'])
    expect(row).to have_content(row['Quantity'])
    expect(row).to have_content(row['Percentage'])
    expect(row).to have_content(row['Years'])
  end
end

When(/^I click on the calculated line "([^"]*)"$/) do |text|
  step("I click \"#{text}\"")
end

Then(/^I must see the already calculated data$/) do
  # TODO:  Refactoring required. Step description context dependant

  # But, I know context. Let's verify.
  expect(page).to have_content('Name: Company XYZ')
  within("//tr[@data-year='5']") do
    expect(page).to have_content('463.71')
  end
end
