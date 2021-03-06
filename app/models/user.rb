class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships

  def already_added?(ticker)
    stock = Stock.find_by_ticker(ticker.upcase)
    return true if (stock && user_stocks.where(stock_id: stock.id).exists?)
    false
  end

  def under_stock_limit?
    user_stocks.count < 10
  end

  def can_add_stock?(ticker)
    !(already_added?(ticker) && under_stock_limit?)
  end

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end

  def self.universe_user_search(params)
    params = params.strip.downcase
    univ_user = User.where('first_name LIKE ?', "%#{params}%")
                    .or(User.where('last_name LIKE ?', "%#{params}%"))
                    .or(User.where('email LIKE ?', "%#{params}%"))
    univ_user
  end

  def exept_current_user(users)
    users.reject {|user| user.id == self.id}
  end



end
