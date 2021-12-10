module Api
  module V1
    class UsersController < ApplicationController
      wrap_parameters :user, include: [:email, :password]
      before_action :authenticate_request!, only: [:show, :update]
      before_action :set_user, only: %i[update show]
      
      # POST /users
      def create
        @user = User.create(user_params)
        if @user.save
          render json: UserRepresenter.new(@user).as_json(true), status: :created
        else
          render json: { error: @user.errors.full_messages.first }, status: :unprocessable_entity
        end
      end

      # GET /users/:id
      def show
        render json: UserRepresenter.new(@user).as_json
      end
   
      # PUT /users/:id
      def update
        @user.update(user_params)
        head :no_content
      end
   
      private
      
      def user_params
        params.require(:user).permit(:email, :password)
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end