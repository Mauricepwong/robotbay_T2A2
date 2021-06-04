class Robot < ApplicationRecord
  has_one_attached :image
  
  belongs_to :user, dependent: :destroy
  
  has_one :sale, class_name: 'Transaction', foreign_key: :robot_id, dependent: :destroy
  
  # has_many :category_robots
  # has_many :categories, { :through => :category_robots }
  has_and_belongs_to_many :categories

  validates :name, presence: true
  validates :price, presence: true

end
