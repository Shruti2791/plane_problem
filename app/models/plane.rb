class Plane < ActiveRecord::Base
  # Associations...................
  has_many :lanes
  has_many :seats, through: :lanes
  accepts_nested_attributes_for :lanes, allow_destroy: :true

  # Callbacks.......................
  after_save :assign_lane_numbers
  after_save :mark_seats

  # Validations.....................
  validates :name, presence: true

  def assign_lane_numbers
    lanes.order(:id).each_with_index { |lane, index| lane.update_column(:number, index + 1) }
  end

  def plan
    lanes.map{|lane| [lane.column, lane.row]}
  end

  def mark_seats
    ordered_lanes = lanes.order(:id).to_a
    ordered_lanes.each_with_index do |lane, index|
      seats = lane.seats.order(:number).to_a.in_groups_of(lane.column, false)
      if index == 0
        seats.each { |row_seats| mark_seats_in_first_lane(row_seats) }
      elsif index == ordered_lanes.length - 1
        seats.each { |row_seats| mark_seats_in_last_lane(row_seats) }
      else
        seats.each { |row_seats| mark_seats_in_middle_lanes(row_seats) }
      end
    end
  end

  def mark_seats_in_first_lane(seats)
    seats.shift.window!
    seats.pop.aisle!
    seats.each { |seat| seat.center! }
  end

  def mark_seats_in_middle_lanes(seats)
    seats.shift.aisle!
    seats.pop.aisle!
    seats.each { |seat| seat.center! }
  end

  def mark_seats_in_last_lane(seats)
    seats.shift.aisle!
    seats.pop.window!
    seats.each { |seat| seat.center! }
  end

  def book_tickets(count)
    return unless seats.available.count >= count
    count.times { book_ticket }
    filled_seats
  end

  def book_ticket
    available_seats = seats.available.order(:row)
    seat = if available_seats.aisle.present?
      available_seats.aisle.first
    elsif available_seats.window.present?
      available_seats.window.first
    else available_seats.center.present?
      available_seats.center.first
    end
    seat.update!(booking_order: seats.booked.order(:booking_order).last&.booking_order.to_i + 1, status: :booked)
  end

  def filled_seats
    seats.booked.order(:booking_order).each_with_index.map { |seat, index| { lane: seat.lane.number, row: seat.row, column: seat.column, booked_number: index + 1 } }
  end
end
