class DocSpeInsDayHouRepresenter
  def initialize(doc_spe_ins_day_hou)
    @doc_spe_ins_day_hou = doc_spe_ins_day_hou
  end
  def as_json
    doctor = doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.doc_spe.doctor.name
    specialization = doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.doc_spe.specialization.name
    institution = doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.institution.name
    day = doc_spe_ins_day_hou.doc_spe_ins_day.day.name
    hour = doc_spe_ins_day_hou.hour.name
    {
        id: doc_spe_ins_day_hou.id,
        doctor: doctor,
        specialization: specialization,
        institution: institution,
        day: day,
        hour: hour,
        date: doc_spe_ins_day_hou.date,
        is_active: doc_spe_ins_day_hou.is_active
    }
  end
  private
  attr_reader :doc_spe_ins_day_hou
end