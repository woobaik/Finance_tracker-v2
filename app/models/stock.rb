class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.search_new_stock(ticker)
    begin
      stock = StockQuote::Stock.quote(ticker)
      searched_stock = Stock.new(ticker: stock.symbol, name:stock.company_name, last_price:stock.close)
    rescue Exception => e
      return nil
    end
  end
end
