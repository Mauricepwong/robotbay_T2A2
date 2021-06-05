class Robot < ApplicationRecord
  # A robot can have one image attached. 
  has_one_attached :image
  
  # Validates that when creating a robot there must be a name and price which is greter then 0. Also that 
  # the image uploaded is of a certain file type. 
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }

  # A robot belongs to 1 user 
  belongs_to :user, dependent: :destroy

  # A robot can have many belongs to many categories. which is connected via the Categories_Robots table  
  has_and_belongs_to_many :categories

  # a Robot can only be sold once so has one sale. Which gets recorded in the transactions. 
  has_one :sale, class_name: 'Transaction', foreign_key: :robot_id, dependent: :destroy

end
