module Api
  module V1
    class UsersController < ApplicationController
      class AuthenticateError < StandardError; end

      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticateError, with: :handle_unauthenticated
      
      wrap_parameters :user, include: [:email, :password, :fullname, :birthdate, :gender, :phone, :identity, :address, :new_password]
      before_action :authenticate_request!, only: [:show, :update_password, :update_personal]
      before_action :set_user, only: %i[show update_password update_personal]

      # GET /users
      def index
        @users = User.order(params[:order]).page(params[:page]).per(params[:per_page])
        render json: CommonRepresenter.new(data: UsersRepresenter.new(@users).as_json, meta: [@users.current_page, @users.limit_value, @users.total_pages, @users.total_count]).as_json
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end
      
      # POST /users
      def create
        @user = User.create(user_params)
        if @user.save
          render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json, code: 201).as_json, status: :created
        else
          render json: CommonRepresenter.new(code: 422, message: @user.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      # GET /users/:id
      def show
        render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json).as_json
      end
   
      # PUT /users/update_personal/:id
      def update_personal
        if @user.update(user_params) 
          render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json).as_json
        else
          render json: CommonRepresenter.new(code: 422, message: @user.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end

      # PUT /users/update_password/:id
      def update_password
        if @user
          raise AuthenticateError unless @user.authenticate(params.require(:password))

          if @user.update({'password' => params[:new_password]})
            render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json).as_json
          else
            render json: CommonRepresenter.new(code: 422, message: @user.errors.full_messages.first).as_json, status: :unprocessable_entity
          end
        else
          render json: CommonRepresenter.new(code: 401, message: 'No such user').as_json, status: :unauthorized
        end
      end
   
      private
      
      def user_params
        params.require(:user).permit(:email, :password, :fullname, :birthdate, :gender, :phone, :identity, :address, :new_password)
      end

      def set_user 
        @user = User.find(params[:id]) 
      rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
      end
    end
  end
end