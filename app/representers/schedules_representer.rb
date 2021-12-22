class SchedulesRepresenter
  def initialize(doc_spe_ins_day_hous)
    @doc_spe_ins_day_hous = doc_spe_ins_day_hous
  end
  def as_json
    schedules = []
    doc_spe_ins_day_hous.map do |doc_spe_ins_day_hou|
      day_id = doc_spe_ins_day_hou.doc_spe_ins_day_id
      institution_id = DocSpeInsDay.find(day_id).doc_spe_in_id
      specialization_id = DocSpeIn.find(institution_id).doc_spe_id
      
      doctor = Doctor.find(DocSpe.find(specialization_id).doctor_id).name
      specialization = Specialization.find(DocSpe.find(specialization_id).specialization_id).name
      institution = Institution.find(DocSpeIn.find(institution_id).institution_id).name
      day = Day.find(DocSpeInsDay.find(day_id).day_id).name
      hour = Hour.find(doc_spe_ins_day_hou.hour_id).name

      if schedules.none?{|a| a[:name] == doctor} 
        schedules.push({name: doctor})
      end
      
      schedules.each_with_index { |v_doc, i_doc|
        if schedules[i_doc][:name] == doctor
          schedule_specialization = schedules[i_doc][:specialization]
          schedule_specialization = [] if schedule_specialization == nil
          schedule_specialization.push({name: specialization}) if schedule_specialization.none?{|a| a[:name] == specialization}

          schedule_specialization.each_with_index { |v_spe, i_spe|
            if schedule_specialization[i_spe][:name] == specialization
              schedule_institution = schedule_specialization[i_spe][:institution]
              schedule_institution = [] if schedule_institution == nil
              schedule_institution.push({name: institution}) if schedule_institution.none?{|a| a[:name] == institution}

              schedule_institution.each_with_index { |v_ins, i_ins|
                if schedule_institution[i_ins][:name] == institution
                  schedule_day = schedule_institution[i_ins][:day]
                  schedule_day = [] if schedule_day == nil
                  schedule_day.push({name: day}) if schedule_day.none?{|a| a[:name] == day}

                  schedule_day.each_with_index { |v_day, i_day|
                    if schedule_day[i_day][:name] == day
                      schedule_hour = schedule_day[i_day][:hour]
                      schedule_hour = [] if schedule_hour == nil
                      schedule_hour.push({id: doc_spe_ins_day_hou.id, name: hour, date: doc_spe_ins_day_hou.date, is_active: doc_spe_ins_day_hou.is_active}) if schedule_hour.none?{|a| a[:name] == hour}
                      schedule_day[i_day][:hour] = schedule_hour
                    end
                  }
                  schedule_institution[i_ins][:day] = schedule_day
                end
              }
              schedule_specialization[i_spe][:institution] = schedule_institution
            end
          }
          schedules[i_doc][:specialization] = schedule_specialization
        end
      }
    end
    schedules
  end
  private
  attr_reader :doc_spe_ins_day_hous
end 