class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :customer_id
      t.integer :staff_id
      t.string :content
      t.timestamps
    end
  end
end
