class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.search_new_stock(params[:stock])
      if @stock
        render 'users/my_portfolio'
      else
        flash[:error] = "We couldn't find the ticker you entered, please enter valid ticker"
        redirect_to my_portfolio_path
      end
    else
      flash[:error] = "Please enter valid input"
      redirect_to my_portfolio_path
    end
  end

end
