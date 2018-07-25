class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :label
      t.string :floor
      t.integer :status
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
