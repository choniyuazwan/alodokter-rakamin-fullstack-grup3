class DocSpeInsDayHousRepresenter
  def initialize(doc_spe_ins_day_hous)
    @doc_spe_ins_day_hous = doc_spe_ins_day_hous
  end
  def as_json
    doc_spe_ins_day_hous.map do |doc_spe_ins_day_hou| {
        id: doc_spe_ins_day_hou.id,
        doctor: Doctor.find(DocSpe.find(DocSpeIn.find(DocSpeInsDay.find(doc_spe_ins_day_hou.doc_spe_ins_day_id).doc_spe_in_id).doc_spe_id).doctor_id).name,
        specialization: Specialization.find(DocSpe.find(DocSpeIn.find(DocSpeInsDay.find(doc_spe_ins_day_hou.doc_spe_ins_day_id).doc_spe_in_id).doc_spe_id).specialization_id).name,
        institution: Institution.find(DocSpeIn.find(DocSpeInsDay.find(doc_spe_ins_day_hou.doc_spe_ins_day_id).doc_spe_in_id).institution_id).name,
        day: Day.find(DocSpeInsDay.find(doc_spe_ins_day_hou.doc_spe_ins_day_id).day_id).name,
        hour: Hour.find(doc_spe_ins_day_hou.hour_id).name,
        date: doc_spe_ins_day_hou.date,
        is_active: doc_spe_ins_day_hou.is_active
      }
    end
  end
  private
  attr_reader :doc_spe_ins_day_hous
end 