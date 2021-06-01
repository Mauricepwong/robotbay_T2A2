class AddNotNullToRobotNamePrice < ActiveRecord::Migration[6.1]
  def change
    change_column_null :robots, :name, false
    change_column_null :robots, :price, false
  end
end
