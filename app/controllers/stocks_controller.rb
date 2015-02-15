# Controller providing CRUD interface for Stock object
class StocksController < ApplicationController
  include StocksHelper
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1
  # GET /stocks/1.json
  # TODO: Condisder refactoring
  def show
    # @calculation_result = @stock.calculation_hash
    #
    # rounded_results = @calculation_result.map do |e|
    #   e[:stock_price].round(2).to_s
    # end
    # @calculation_result_for_chartjs = "[#{rounded_results.join(', ')}]"
    # result_years = @calculation_result.map { |e| e[:year] }
    # @labels_for_chartjs = "[#{ result_years.join(', ')}]"
    #
    # @max_value_show_as_long = 10**9
    @calculation_result = @stock.calculation_hash
    results = @stock.result_for_chartjs
    @calculation_result_for_chartjs = results[:values]
    @labels_for_chartjs = results[:labels]
    @max_value_show_as_long = 10**9
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        create_action_html_format(format)
        create_action_json_format(format)
      else
        render_action_or_error(format, 'new')
      end
    end
  end

  def create_action_json_format(format)
    format.json do
      render action: 'show',
             status: :created,
             location: @stock
    end
  end

  def create_action_html_format(format)
    format.html do
      redirect_to @stock,
                  notice: 'Stock was successfully created.'
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        update_format_html(format)
        format.json { head :no_content }
      else
        render_action_or_error(format, 'edit')
      end
    end
  end

  def update_format_html(format)
    format.html do
      redirect_to @stock,
                  notice: 'Stock was successfully updated.'
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url }
      format.json { head :no_content }
    end
  end

  private

  def render_action_or_error(format, action)
    format.html { render action: action }
    format.json { render json: @stock.errors, status: :unprocessable_entity }
  end

  def set_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:name,
                                  :price,
                                  :quantity,
                                  :percentage,
                                  :years)
  end
end
