module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only: :show

      def index
        # order = params[:order].to_s + " " + params[:sort].to_s 
        @articles = Article.query(params[:search], params[:category], params[:headline]).order(params[:order]).page(params[:page]).per(params[:per_page])
        render json: CommonRepresenter.new(data: ArticlesRepresenter.new(@articles).as_json, meta: [@articles.current_page, @articles.limit_value, @articles.total_pages, @articles.total_count]).as_json
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      def create
        @article = Article.create(article_params)
        if @article.save
          render json: CommonRepresenter.new(data: ArticleRepresenter.new(@article).as_json, code: 201).as_json, status: :created
        else
          render json: CommonRepresenter.new(code: 422, message: @article.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      def show
        render json: CommonRepresenter.new(data: ArticleRepresenter.new(@article).as_json).as_json
      end

      private

      def article_params
        params.permit(:title, :category_id, :content, :image, :reviewer_id, :headline)
      end

      def set_article
        @article = Article.find(params[:id])
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end
    end
  end
end
