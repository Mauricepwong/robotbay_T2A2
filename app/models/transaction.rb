class Transaction < ApplicationRecord
  belongs_to :seller, class_name: 'User', dependent: :destroy 
  belongs_to :buyer, class_name: 'User', dependent: :destroy
  belongs_to :robot, dependent: :destroy
end
