class Api::SessionsController < ApplicationController
    before_action :authenticate_user, only: :destroy

    def create
        user = User.find_by(email: session_params[:email])
        if user&.authenticate(session_params[:password])
            token = SecureRandom.hex(20)
            expires_at = 1.hour.from_now

            user.update!(token: token, token_expires_at: expires_at)

            render json: {
            message: "Logged in successfully.",
            token: token,
            expires_at: expires_at,
            data: UserSerializer.new(user).as_json
            }, status: :ok
        else
            render json: { error: "Invalid email or password." }, status: :unauthorized
        end
    end

    def destroy
        @current_user.update!(token: nil, token_expires_at: nil)
        render json: { message: "Logged out successfully." }, status: :ok
    end

    private

    def session_params
        params.require(:session).permit(:email, :password)
    end

    def authenticate_user
        token = request.headers['Authorization']
        @current_user = User.find_by(token: token)

        unless @current_user
            render json: { error: "Invalid token." }, status: :unauthorized
        end
    end
end
