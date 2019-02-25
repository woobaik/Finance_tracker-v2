class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def already_added?(ticker)
    stock = Stock.find_by_ticker(ticker.upcase)
    return true if stock && user_stocks.where(stock_id: stock.id)
    false
  end

  def under_stock_limit?
    user_stocks.count < 10
  end

  def can_add_stock?(ticker)
    already_added?(ticker) && under_stock_limit?
  end


end
