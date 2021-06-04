class Robot < ApplicationRecord
  has_one_attached :image
  belongs_to :user, dependent: :destroy
  has_one :sale, class_name: 'Transaction', foreign_key: :robot_id, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true

end
