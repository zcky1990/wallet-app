class ApplicationController < ActionController::API
    def as_json(options = {})
        super(options.merge({ except: [:password_digest] }))
    end

    private

    def authenticate_request
        token = request.headers['Authorization']
        @current_user = User.find_by(token: token)
    
        if @current_user.nil? || token_expired?
            render json: { error: "Unauthorized" }, status: :unauthorized
        end
    end
    
    def token_expired?
        @current_user.token_expires_at < Time.current
    end
end
