class SchedulesRepresenter
  def initialize(doc_spe_ins_day_hous)
    @doc_spe_ins_day_hous = doc_spe_ins_day_hous
  end
  def as_json
    schedules = []
    doc_spe_ins_day_hous.map do |doc_spe_ins_day_hou|
      doctor = Doctor.find(DocSpe.find(DocSpeIn.find(DocSpeInsDay.find(doc_spe_ins_day_hou.doc_spe_ins_day_id).doc_spe_in_id).doc_spe_id).doctor_id).name
      specialization = Specialization.find(DocSpe.find(DocSpeIn.find(DocSpeInsDay.find(doc_spe_ins_day_hou.doc_spe_ins_day_id).doc_spe_in_id).doc_spe_id).specialization_id).name
      institution = Institution.find(DocSpeIn.find(DocSpeInsDay.find(doc_spe_ins_day_hou.doc_spe_ins_day_id).doc_spe_in_id).institution_id).name
      day = Day.find(DocSpeInsDay.find(doc_spe_ins_day_hou.doc_spe_ins_day_id).day_id).name
      hour = Hour.find(doc_spe_ins_day_hou.hour_id).name

      if schedules.none?{|a| a[:name] == doctor} 
        schedules.push({name: doctor})
      end
      
      schedules.each_with_index { |v_doc, i_doc|
        if schedules[i_doc][:name] == doctor
          schedules[i_doc][:specialization] = [] if schedules[i_doc][:specialization] == nil
          schedules[i_doc][:specialization].push({name: specialization}) if schedules[i_doc][:specialization].none?{|a| a[:name] == specialization}

          schedules[i_doc][:specialization].each_with_index { |v_spe, i_spe|
            if schedules[i_doc][:specialization][i_spe][:name] == specialization
              schedules[i_doc][:specialization][i_spe][:institution] = [] if schedules[i_doc][:specialization][i_spe][:institution] == nil
              schedules[i_doc][:specialization][i_spe][:institution].push({name: institution}) if schedules[i_doc][:specialization][i_spe][:institution].none?{|a| a[:name] == institution}

              schedules[i_doc][:specialization][i_spe][:institution].each_with_index { |v_ins, i_ins|
                if schedules[i_doc][:specialization][i_spe][:institution][i_ins][:name] == institution
                  schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day] = [] if schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day] == nil
                  schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day].push({name: day}) if schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day].none?{|a| a[:name] == day}

                  schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day].each_with_index { |v_day, i_day|
                    if schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day][i_day][:name] == day
                      schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day][i_day][:hour] = [] if schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day][i_day][:hour] == nil
                      schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day][i_day][:hour].push({id: doc_spe_ins_day_hou.id, name: hour, date: doc_spe_ins_day_hou.date, is_active: doc_spe_ins_day_hou.is_active}) if schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day][i_day][:hour].none?{|a| a[:name] == hour}
                    end
                  }
                end
              }
            end
          }
        end
      }
    end
    schedules
  end
  private
  attr_reader :doc_spe_ins_day_hous
end 