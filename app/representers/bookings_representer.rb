class BookingsRepresenter
  def initialize(bookings)
    @bookings = bookings
  end
  def as_json
    bookings.map do |booking| {
        id: booking.id,
        user_id: booking.user_id,
        doc_spe_ins_day_hou_id: booking.doc_spe_ins_day_hou_id,
        created_at: booking.created_at
    } end
  end
  private
  attr_reader :bookings
end