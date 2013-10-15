require 'spec_helper'

describe Stock do
  let(:valid_attributes) { { "name" => "Company XYZ",
                             "price" => 2,
                             "quantity" => 200,
                             "percentage" => 3,
                             "years" => 10
  }}

  context "correct attributes behaviour" do
    before(:all) do
      @stock = Stock.new(valid_attributes)
    end

    subject { @stock }

    it { should respond_to :name }
    it { should respond_to :price }
    it { should respond_to :quantity }
    it { should respond_to :percentage }
    it { should respond_to :years }

    it "should correctly return calculation for specific year" do
      @stock.price_for_year(2).should be_within(0.001).of(424.36)
    end

    test_hash = {year: 0, stock_price: 400.00},
        {year: 1, stock_price: 412.00},
        {year: 2, stock_price: 424.36},
        {year: 3, stock_price: 437.09},
        {year: 4, stock_price: 450.20},
        {year: 5, stock_price: 463.71},
        {year: 6, stock_price: 477.62},
        {year: 7, stock_price: 491.95},
        {year: 8, stock_price: 506.71},
        {year: 9, stock_price: 521.91},
        {year: 10, stock_price: 537.57}

    it "should correctly return hash of calculations for specific year" do
      hash = @stock.get_calculation_hash
      hash.select{|x| x[:year]==2}.first[:stock_price].should be == 424.36
    end

  end

end
