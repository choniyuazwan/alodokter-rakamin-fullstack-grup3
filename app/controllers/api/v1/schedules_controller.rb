class Api::V1::SchedulesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_doctor, only: :show

  def index
    @doctors = Doctor.order(params[:order]).page(params[:page]).per(params[:per_page])
    render json: CommonRepresenter.new(data: SchedulesRepresenter.new(@doctors).as_json, meta: [@doctors.current_page, @doctors.limit_value, @doctors.total_pages, @doctors.total_count]).as_json
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end

  def show
    render json: CommonRepresenter.new(data: ScheduleRepresenter.new(@doctor).as_json).as_json
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end
end
