module Api
  module V1
    class SpecializationsController < ApplicationController
      before_action :set_specialization, only: :show

      def index
        @specializations = Specialization.order(params[:order]).page(params[:page]).per(params[:per_page])
        render json: CommonRepresenter.new(data: RegularsRepresenter.new(@specializations).as_json, meta: [@specializations.current_page, @specializations.limit_value, @specializations.total_pages, @specializations.total_count]).as_json
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      def create
        @specialization = Specialization.create(specialization_params)
        if @specialization.save
          render json: CommonRepresenter.new(data: RegularRepresenter.new(@specialization).as_json, code: 201).as_json, status: :created
        else
          render json: CommonRepresenter.new(code: 422, message: @specialization.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      def show
        render json: CommonRepresenter.new(data: RegularRepresenter.new(@specialization).as_json).as_json
      end

      private

      def specialization_params
        params.permit(:name)
      end

      def set_specialization
        @specialization = Specialization.find(params[:id])
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end
    end
  end
end