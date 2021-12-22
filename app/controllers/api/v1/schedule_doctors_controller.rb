class Api::V1::ScheduleDoctorsController < ApplicationController
  before_action :authenticate_request!

  def index
    @doctors = Doctor.order(params[:order]).page(params[:page]).per(params[:per_page])
    schedules = []
    @doctors.each_with_index do |v_doc, i_doc|
      schedules.push({name: v_doc[:name], specialization: []})
      
      v_doc.doc_spes.each_with_index { |v_spe, i_spe|
        schedules[i_doc][:specialization].push({name: v_spe.specialization.name, institution: []})
        
        v_spe.doc_spe_ins.each_with_index { |v_ins, i_ins|
          institution = v_ins.institution
          coordinate = {latitude: institution.latitude, longitude: institution.longitude}
          schedules[i_doc][:specialization][i_spe][:institution].push({name: institution.name, location: institution.location, price: v_ins.price, coordinate: coordinate, day: []})
          
          v_ins.doc_spe_ins_days.each_with_index { |v_day, i_day|
            schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day].push({name: v_day.day.name, hour: []})
            
            v_day.doc_spe_ins_day_hous.each_with_index { |v_hou, i_hou|
              schedules[i_doc][:specialization][i_spe][:institution][i_ins][:day][i_day][:hour].push({id: v_hou.id, name: v_hou.hour.name, date: v_hou.date, is_active: v_hou.is_active})
            
            }
          }
        }
      }
    end
    
    render json: CommonRepresenter.new(data: schedules, meta: [@doctors.current_page, @doctors.limit_value, @doctors.total_pages, @doctors.total_count]).as_json
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end
end
