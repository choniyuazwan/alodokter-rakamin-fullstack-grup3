class Api::V1::PasswordsController < ApplicationController

    def new 

    end

    def create 
        @user = User.find_by(email: params[:email])

        if @user.present?
            PasswordMailer.with(user: @user).forget.deliver_now  
            render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json).as_json
        else
            render json: CommonRepresenter.new(code: 422, message: @user.errors.full_messages.first).as_json, status: :unprocessable_entity
        end
    end 

    def edit 
        @user = User.find_signed!(params[:token], purpose: "password_forget")
        rescue ActiveSupport::MessageVerifier::InvalidSignature
        render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json).as_json
    end

    def update 
        @user = User.find_signed!(params[:token], purpose: "password_forget")
        if @user.update(password_params)
            render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json).as_json 
        else 
            render :edit
        end
    end

    private 
    def password_params 
        params.require(:user).permit(:password, :password_confirmation)
    end
end
