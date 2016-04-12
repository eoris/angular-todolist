class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file
      t.belongs_to :comment

      t.timestamps null: false
    end
  end
end
