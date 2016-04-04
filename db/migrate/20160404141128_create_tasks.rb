class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.date :deadline
      t.integer :position
      t.boolean :done
      t.belongs_to :project

      t.timestamps null: false
    end
  end
end
