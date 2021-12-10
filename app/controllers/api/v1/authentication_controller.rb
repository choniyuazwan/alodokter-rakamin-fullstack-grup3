module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticateError < StandardError; end

      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticateError, with: :handle_unauthenticated

      def create
        if user
          raise AuthenticateError unless user.authenticate(params.require(:password))

          render json: CommonRepresenter.new(data: UserRepresenter.new(user).as_json(true), code: 201).as_json, status: :created
        else
          render json: CommonRepresenter.new(code: 401, message: 'No such user').as_json, status: :unauthorized
        end
      end

      private

      def user
        @user ||= User.find_by(email: params.require(:email))
      end

      def parameter_missing(error)
        render json: CommonRepresenter.new(code: 422, message: error.message).as_json, status: :unprocessable_entity
      end

      def handle_unauthenticated
        render json: CommonRepresenter.new(code: 401, message: 'Incorrect password').as_json, status: :unauthorized
      end
    end
  end
end