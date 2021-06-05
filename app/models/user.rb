class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :timeoutable :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable 

  # validates that there is an email present and that it is unique so users cant have the same account. 
  validates :email, presence: true, uniqueness: true

  # A User can have many robots and if user is deleted their robots will too. 
  has_many :robots, dependent: :destroy
  
  # A User can be a seller or buyer of a robot. When a purchase is made, a transaction (joining table) is created 
  # with the user_ids recorded to the respective seller/buyer ID. This give access to the sold robots and purchased robots.
  # A user can have many purchases and sales, which turn means that they can have many sold_robots and 
  # many purchased robots.

  has_many :sales, class_name: 'Transaction', foreign_key: :seller_id, dependent: :destroy
  has_many :sold_robots, through: :sales, source: :robot, dependent: :destroy

  has_many :purchases, class_name: 'Transaction', foreign_key: :buyer_id, dependent: :destroy
  has_many :purchased_robots, through: :purchases, source: :robot, dependent: :destroy

  scope :sellers, -> { joins(:sales) }
  scope :buyers, -> { joins(:purchases) }
end
