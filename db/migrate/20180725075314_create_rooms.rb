class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :label
      t.integer :floor
      t.integer :status, default: 0
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
