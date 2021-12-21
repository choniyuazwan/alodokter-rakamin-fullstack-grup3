class BookingRepresenter
  def initialize(booking)
    @booking = booking
  end
  def as_json
    {
        id: booking.id,
        user_id: booking.user_id,
        doc_spe_ins_day_hou_id: booking.doc_spe_ins_day_hou_id,
        created_at: booking.created_at
    }
  end
  private
  attr_reader :booking
end