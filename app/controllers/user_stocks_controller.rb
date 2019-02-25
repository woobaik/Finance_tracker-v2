class UserStocksController < ApplicationController
  def create
    stock = Stock.find_by_ticker(params[:stock_ticker])
    if stock.nil?
      stock = Stock.search_new_stock(params[:stock_ticker])
      stock.save
    end
    @user_stock = UserStock.create(user:current_user, stock:stock)
    flash[:success] = "Your stock #{@user_stock.stock.name} has been saved!"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find_by_id(params[:id])
    user_stock = UserStock.where(user_id: current_user, stock_id: stock.id).first
    user_stock.destroy
    flash[:success] = "Your stock #{stock.name} has been deleted!"
    redirect_to my_portfolio_path
  end
end
