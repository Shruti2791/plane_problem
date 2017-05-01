class Lane < ActiveRecord::Base
  # Associations....................
  belongs_to :plane
  has_many :seats

  # Callbacks.......................
  before_save :save_seats

  # Validations.....................
  validates :row, :column, presence: true

  def save_seats
    row.times do |row_count|
      row_count = row_count + 1
      number = seats.last&.number || 1
      seating = (number..(number + column - 1)).to_a
      seating.each_with_index do |seat_number, index|
        seats.build(number: seat_number, row: row_count, column: index + 1)
      end
   end
  end
end
