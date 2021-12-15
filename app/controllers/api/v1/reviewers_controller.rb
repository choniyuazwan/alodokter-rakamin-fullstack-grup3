module Api
  module V1
    class ReviewersController < ApplicationController
      before_action :set_reviewer, only: :show
      
      def index
        @reviewers = Reviewer.order(params[:order]).page(params[:page]).per(params[:per_page])
        render json: CommonRepresenter.new(data: ReviewersRepresenter.new(@reviewers).as_json, meta: [@reviewers.current_page, @reviewers.limit_value, @reviewers.total_pages, @reviewers.total_count]).as_json
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      def create
        @reviewer = Reviewer.create(reviewer_params)
        if @reviewer.save 
          render json: CommonRepresenter.new(data: ReviewerRepresenter.new(@reviewer).as_json, code: 201).as_json, status: :created
        else
          render json: CommonRepresenter.new(code: 422, message: @reviewer.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      def show
        render json: CommonRepresenter.new(data: ReviewerRepresenter.new(@reviewer).as_json).as_json
      end
      
      private
      
      def reviewer_params
        params.permit(:name)
      end
      
      def set_reviewer
        @reviewer = Reviewer.find(params[:id])
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end
    end
  end
end