module Api
  module V1
    class InstitutionsController < ApplicationController
      before_action :set_institution, only: :show

      def index
        @institutions = Institution.order(params[:order]).page(params[:page]).per(params[:per_page])
        render json: CommonRepresenter.new(data: RegularsRepresenter.new(@institutions).as_json, meta: [@institutions.current_page, @institutions.limit_value, @institutions.total_pages, @institutions.total_count]).as_json
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      def create
        @institution = Institution.create(institution_params)
        if @institution.save
          render json: CommonRepresenter.new(data: RegularRepresenter.new(@institution).as_json, code: 201).as_json, status: :created
        else
          render json: CommonRepresenter.new(code: 422, message: @institution.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      def show
        render json: CommonRepresenter.new(data: RegularRepresenter.new(@institution).as_json).as_json
      end

      private

      def institution_params
        params.permit(:name)
      end

      def set_institution
        @institution = Institution.find(params[:id])
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end
    end
  end
end