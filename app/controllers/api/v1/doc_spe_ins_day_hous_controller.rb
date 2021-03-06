class Api::V1::DocSpeInsDayHousController < ApplicationController
  before_action :authenticate_request!
  before_action :set_doc_spe_ins_day_hou, only: :show

  def index
    @doc_spe_ins_day_hous = DocSpeInsDayHou.order(params[:order]).page(params[:page]).per(params[:per_page])
    render json: CommonRepresenter.new(data: DocSpeInsDayHousRepresenter.new(@doc_spe_ins_day_hous).as_json, meta: [@doc_spe_ins_day_hous.current_page, @doc_spe_ins_day_hous.limit_value, @doc_spe_ins_day_hous.total_pages, @doc_spe_ins_day_hous.total_count]).as_json
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end

  def show
    render json: CommonRepresenter.new(data: DocSpeInsDayHouRepresenter.new(@doc_spe_ins_day_hou).as_json).as_json
  end

  private

  def set_doc_spe_ins_day_hou
    @doc_spe_ins_day_hou = DocSpeInsDayHou.find(params[:id])
  rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
  end
end
