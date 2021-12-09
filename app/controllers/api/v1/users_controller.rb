module Api
  module V1
    class UsersController < ApplicationController
      wrap_parameters :user, include: [:email, :password]
      def create
        @user = User.create(user_params)
        if @user.save
          render json: UserRepresenter.new(@user).as_json, status: :created
        else
          render json: { error: @user.errors.full_messages.first }, status: :unprocessable_entity
        end
      end
      private
      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end