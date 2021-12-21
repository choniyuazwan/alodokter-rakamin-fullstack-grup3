class Api::V1::PasswordsController < ApplicationController
    def create 
        @user = User.find_by(email: params[:email])

        if @user.present?
            PasswordMailer.with(user: @user).forget.deliver_now  
            render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json).as_json
        else
            render json: CommonRepresenter.new(code: 401, message: 'No such user').as_json, status: :unauthorized
        end
    rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
    end 

    def edit 
        @user = User.find_signed!(params[:token], purpose: "password_forget")
        rescue ActiveSupport::MessageVerifier::InvalidSignature
        render json: CommonRepresenter.new.as_json
    rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
    end

    def update 
        @user = User.find_signed!(params[:token], purpose: "password_forget")
        if @user.update(password_params)
            render json: CommonRepresenter.new(data: UserRepresenter.new(@user).as_json).as_json 
        else 
            render :edit
        end
    rescue StandardError => e; render json: CommonRepresenter.new(code: 400, message: e.to_s).as_json, status: :bad_request
    end

    private 
    def password_params 
        params.require(:user).permit(:password, :password_confirmation)
    end
end
