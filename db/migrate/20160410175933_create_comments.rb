class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text, null: false
      t.belongs_to :task, null: false

      t.timestamps null: false
    end
  end
end
