class CreateBookingDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_details do |t|
      t.references :booking, foreign_key: true
      t.references :room, foreign_key: true
      t.timestamps
    end
  end
end
