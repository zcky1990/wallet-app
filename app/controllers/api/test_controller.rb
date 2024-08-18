class Api::TestController < ApplicationController
    before_action :authenticate_request

    def show
        render json: { message: "Status OK." }, status: :ok
    end
end 

### Curl example test session ###
# curl --location --request GET 'http://localhost:3000/api/test' \
# --header 'Content-Type: application/json' \
# --header 'Authorization: 7b81f444bc09b2248bc87a5494d9061fef0b0706' \
# --data-raw '{
#   "email": "admin@example.com",
#   "password": "password"
# }'