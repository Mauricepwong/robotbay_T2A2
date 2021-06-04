class Category < ApplicationRecord
#    has_many :category_robots
#    has_many :robots, { :through => :category_robots }
has_and_belongs_to_many :robots
end
