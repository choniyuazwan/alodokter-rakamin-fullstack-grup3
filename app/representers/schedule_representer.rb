class ScheduleRepresenter
  def initialize(doctor)
    @doctor = doctor
  end
  def as_json
    schedule = {name: doctor[:name]}

    doctor.doc_spes.each_with_index { |v_spe, i_spe|
      specialization = schedule[:specialization]
      specialization = [] if specialization == nil
      specialization.push({name: v_spe.specialization.name})

      v_spe.doc_spe_ins.each_with_index { |v_ins, i_ins|
        coordinate = {latitude: v_ins.institution.latitude, longitude: v_ins.institution.longitude}
        institution = specialization[i_spe][:institution]
        institution = [] if institution == nil
        institution.push({name: v_ins.institution.name, location: v_ins.institution.location, price: v_ins.price, coordinate: coordinate})

        v_ins.doc_spe_ins_days.each_with_index { |v_day, i_day|
          day = institution[i_ins][:day]
          day = [] if day == nil
          day.push({name: v_day.day.name})

          v_day.doc_spe_ins_day_hous.each_with_index { |v_hou, i_hou|
            hour = day[i_day][:hour]
            hour = [] if hour == nil
            hour.push({id: v_hou.id, name: v_hou.hour.name, date: v_hou.date, is_active: v_hou.is_active})
            day[i_day][:hour] = hour
          }
          institution[i_ins][:day] = day
        }
        specialization[i_spe][:institution] = institution
      }
      schedule[:specialization] = specialization
    }
    schedule
  end
  private
  attr_reader :doctor
end