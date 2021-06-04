class CreateCategoryRobots < ActiveRecord::Migration[6.1]
  def change
    create_table :categories_robots do |t|
      t.references :robot, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
