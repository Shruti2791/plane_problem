class AddPlaneIdToLane < ActiveRecord::Migration
  def change
    add_reference :lanes, :plane, index: true, foreign_key: true
  end
end
