class Category < ApplicationRecord
    # A category has a many to many relationship with6 robots. This is through Categories_Robots
    has_and_belongs_to_many :robots

    # Validates that name is present when category is created
    validates :name, presence: true
end
