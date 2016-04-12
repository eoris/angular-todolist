class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.belongs_to :user, index: true, null: false

      t.timestamps null: false
    end
  end
end
