module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: :show
      
      def index
        @categories = Category.order(params[:order]).page(params[:page]).per(params[:per_page])
        render json: CommonRepresenter.new(data: RegularsRepresenter.new(@categories).as_json, meta: [@categories.current_page, @categories.limit_value, @categories.total_pages, @categories.total_count]).as_json
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      def create
        @category = Category.create(category_params)
        if @category.save 
          render json: CommonRepresenter.new(data: RegularRepresenter.new(@category).as_json, code: 201).as_json, status: :created
        else
          render json: CommonRepresenter.new(code: 422, message: @category.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      def show
        render json: CommonRepresenter.new(data: RegularRepresenter.new(@category).as_json).as_json
      end
      
      private
      
      def category_params
        params.permit(:name)
      end
      
      def set_category
        @category = Category.find(params[:id])
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end
    end
  end
end