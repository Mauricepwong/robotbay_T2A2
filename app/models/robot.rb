class Robot < ApplicationRecord
  has_one_attached :image
  belongs_to :user, dependent: :destroy
  

  validates :name, presence: true
  validates :price, presence: true
end
