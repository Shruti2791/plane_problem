class CreateLanes < ActiveRecord::Migration
  def change
    create_table :lanes do |t|
      t.integer :row
      t.integer :column

      t.timestamps null: false
    end
  end
end
