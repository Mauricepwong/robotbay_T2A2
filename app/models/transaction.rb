class Transaction < ApplicationRecord
  # This is a joining table. When a purchase is made and a transaction is created which contains 
  # a seller user, buyer user and robot id. 
  
  belongs_to :seller, class_name: 'User', dependent: :destroy 
  belongs_to :buyer, class_name: 'User', dependent: :destroy
  belongs_to :robot, dependent: :destroy
end
