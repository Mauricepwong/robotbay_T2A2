class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable # :timeoutable

  has_many :robots

  has_many :sales, class_name: 'Transaction', foreign_key: :seller_id
  has_many :sold_robots, through: :sales, source: :robot

  has_many :purchases, class_name: 'Transaction', foreign_key: :buyer_id
  has_many :purchased_robots, through: :purchases, source: :robot

  #  has_one_attached :avatar
  scope :sellers, -> { joins(:sales) }
  scope :buyers, -> { joins(:purchases) }
end
