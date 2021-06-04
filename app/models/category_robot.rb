class CategoryRobot < ApplicationRecord
  self.table_name = "categories_robots"
  belongs_to :robot
  belongs_to :category
end
