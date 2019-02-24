class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.search_new_stock(params[:stock])
      if @stock
        respond_to do |format|
          format.js {render partial: 'users/result'}
        end
      else
        flash.now[:error] = "We couldn't find the ticker you entered, please enter valid ticker"
        redirect_to my_portfolio_path
      end
    else
      flash.now[:error] = "Please enter valid input"
      redirect_to my_portfolio_path
    end
  end

end
