class AddSoldToRobots < ActiveRecord::Migration[6.1]
  def change
    add_column :robots, :sold, :boolean, default: false
  end
end
