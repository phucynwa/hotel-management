class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :booking, foreign_key: true
      t.integer :priority
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
