class DocSpeInsDayHousRepresenter
  def initialize(doc_spe_ins_day_hous)
    @doc_spe_ins_day_hous = doc_spe_ins_day_hous
  end
  def as_json
    doc_spe_ins_day_hous.map do |doc_spe_ins_day_hou| {
        id: doc_spe_ins_day_hou.id,
        doctor: doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.doc_spe.doctor.name,
        specialization: doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.doc_spe.specialization.name,
        institution: doc_spe_ins_day_hou.doc_spe_ins_day.doc_spe_in.institution.name,
        day: doc_spe_ins_day_hou.doc_spe_ins_day.day.name,
        hour: doc_spe_ins_day_hou.hour.name,
        date: doc_spe_ins_day_hou.date,
        is_active: doc_spe_ins_day_hou.is_active
      }
    end
  end
  private
  attr_reader :doc_spe_ins_day_hous
end 