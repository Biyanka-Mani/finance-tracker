class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks
  has_many :stocks,through: :user_stocks
  has_many :friendships
  has_many :friends ,through: :friendships
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
    stock=Stock.check_db(ticker_symbol)
    return false unless stock 
    stocks.where(id:stock.id).exists?

  end
 def expect_current_user(collection_friends)
  collection_friends.reject {|user| user.id == self.id}

 end

  def under_stock_limit?
    stocks.count < 8
  end

  def can_track_stock?(ticker_symbol)
    
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end
  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}" 
    else
    "Anonymous"
    end
  end
  def not_friends_with?(friend_id)
    !self.friends.where(id:friend_id).exists?
  end

  def self.search(param)
    param.strip! 
    to_send_back=(first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    returmn nil unless to_send_back
    to_send_back
  end
  def self.first_name_matches(param)
    where("first_name LIKE ?","%#{param}%")
  end
  def self.last_name_matches(param)
    where("last_name LIKE ?","%#{param}%")
  end
  def self.email_matches(param)
    where("email LIKE ?","%#{param}%")
  end

  # def self.matches(field_name,param)
  #   where("#{field_name} LIKE ?","%#{param}%")
  # end
end
