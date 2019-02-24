class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.search_new_stock(params[:stock])
      if @stock
        respond_to do |format|
          format.js {render partial: 'users/result'}
        end
      else
        respond_to do |format|
        flash.now[:danger] = "We couldn't find the ticker you entered, please enter valid ticker"
        format.js {render partial: 'users/result'}
      end
      end
    else
      respond_to do |format|
        flash.now[:danger] = "Please enter valid input"
        format.js {render partial: 'users/result'}
      end
    end
  end

end
