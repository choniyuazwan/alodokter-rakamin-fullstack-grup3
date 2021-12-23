class Api::V1::BookingsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_booking, only: :show
  
  def index
    @bookings = current_user!.bookings.order(params[:order]).page(params[:page]).per(params[:per_page])
    render json: CommonRepresenter.new(data: BookingsRepresenter.new(@bookings).as_json, meta: [@bookings.current_page, @bookings.limit_value, @bookings.total_pages, @bookings.total_count]).as_json
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end

  def create
    schedule = DocSpeInsDayHou.find(booking_params[:doc_spe_ins_day_hou_id])
    if schedule.is_active == false
      return render json: CommonRepresenter.new(code: 422, message: "doctor's schedule is no longer available").as_json, status: :unprocessable_entity
    end
    
    @booking = current_user!.bookings.create(booking_params)
    if @booking.save
      schedule.update(is_active: false)
      render json: CommonRepresenter.new(data: BookingRepresenter.new(@booking).as_json, code: 201).as_json, status: :created
    else
      render json: CommonRepresenter.new(code: 422, message: @booking.errors.full_messages.first).as_json, status: :unprocessable_entity
    end
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end

  def show
    render json: CommonRepresenter.new(data: BookingRepresenter.new(@booking).as_json).as_json
  end

  private

  def booking_params
    params.permit(:user_id, :doc_spe_ins_day_hou_id)
  end

  def set_booking
    @booking = current_user!.bookings.find(params[:id])
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end
end
