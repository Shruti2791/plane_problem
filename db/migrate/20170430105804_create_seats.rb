class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.references :lane, index: true, foreign_key: true
      t.integer :number
      t.integer :status, default: Seat.statuses[:available]
      t.integer :kind
      t.integer :booking_order

      t.timestamps null: false
    end
  end
end
