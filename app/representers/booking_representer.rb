class BookingRepresenter
  def initialize(booking)
    @booking = booking
  end
  def as_json
    {
        id: booking.id,
        doctor: booking.doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.doc_spe.doctor.name,
        specialization: booking.doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.doc_spe.specialization.name,
        institution: booking.doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.institution.name,
        location: booking.doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.institution.location,
        price: booking.doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.price,
        day: booking.doc_spe_ins_day_hou.doc_spe_ins_day.day.name,
        hour: booking.doc_spe_ins_day_hou.hour.name,
        date: booking.doc_spe_ins_day_hou.date,
        created_at: booking.created_at
    }
  end
  private
  attr_reader :booking
end