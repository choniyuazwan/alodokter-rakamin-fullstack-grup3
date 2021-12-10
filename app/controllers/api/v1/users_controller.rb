module Api
  module V1
    class UsersController < ApplicationController
      wrap_parameters :user, include: [:email, :password, :firstname, :lastname, :birthdate, :gender, :phone, :identity, :address, :city]
      before_action :authenticate_request!, only: [:show, :update]
      before_action :set_user, only: %i[update show]
      
      # POST /users
      def create
        @user = User.create(user_params)
        if @user.save
          render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json, code: 201).as_json, status: :created
        else
          render json: CommonRepresenter.new(code: 422, message: @user.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
      end

      # GET /users/:id
      def show
        render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json).as_json
      end
   
      # PUT /users/:id
      def update
        if @user.update(user_params) 
          # head :no_content
          render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json).as_json
        else
          render json: CommonRepresenter.new(code: 422, message: @user.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
        
      end
   
      private
      
      def user_params
        params.require(:user).permit(:email, :password, :firstname, :lastname, :birthdate, :gender, :phone, :identity, :address, :city)
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end