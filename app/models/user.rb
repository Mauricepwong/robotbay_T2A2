class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :timeoutable :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable 

  validates :email, presence: true

  has_many :robots, dependent: :destroy
  
  has_many :sales, class_name: 'Transaction', foreign_key: :seller_id, dependent: :destroy
  has_many :sold_robots, through: :sales, source: :robot, dependent: :destroy

  has_many :purchases, class_name: 'Transaction', foreign_key: :buyer_id, dependent: :destroy
  has_many :purchased_robots, through: :purchases, source: :robot, dependent: :destroy

  #  has_one_attached :avatar
  scope :sellers, -> { joins(:sales) }
  scope :buyers, -> { joins(:purchases) }
end
