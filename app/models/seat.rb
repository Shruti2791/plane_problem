class Seat < ActiveRecord::Base
  belongs_to :lane
  enum status: [:available, :booked]
  enum kind: [:window, :center, :aisle]
end
