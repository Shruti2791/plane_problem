class AddNumberToLane < ActiveRecord::Migration
  def change
    add_column :lanes, :number, :integer
  end
end
