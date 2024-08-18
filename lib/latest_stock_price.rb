require 'faraday'
require 'json'

module LatestStockPrice
    class Error < StandardError; end
    class ConnectionError < Error; end
    class TimeoutError < Error; end
    class ResponseError < Error; end

    class Client
        BASE_URL = 'https://latest-stock-price.p.rapidapi.com'

        def initialize(api_key)
        @api_key = api_key
            @connection = Faraday.new(url: BASE_URL) do |faraday|
                faraday.request :url_encoded
                faraday.response :logger                  # Logs requests to STDOUT
                faraday.adapter Faraday.default_adapter   # Makes Faraday use Net::HTTP under the hood
            end
        end

        def price(symbol)
            request('/price', { symbol: symbol })
        end

        def prices(symbols)
            request('/prices', { symbols: symbols })
        end

        def price_all
            request('/price_all')
        end

        private

        def request(endpoint, params = {})
            response = @connection.get(endpoint, params) do |req|
                req.headers['X-RapidAPI-Key'] = @api_key
                req.headers['X-RapidAPI-Host'] = 'latest-stock-price.p.rapidapi.com'
            end

            handle_response(response)
        rescue Faraday::ConnectionFailed => e
            raise ConnectionError, "Connection failed: #{e.message}"
        rescue Faraday::TimeoutError => e
            raise TimeoutError, "Request timed out: #{e.message}"
        rescue Faraday::ClientError => e
            raise ResponseError, "Client error: #{e.message}"
        rescue StandardError => e
            raise Error, "An unexpected error occurred: #{e.message}"
        end

        def handle_response(response)
            if response.success?
                JSON.parse(response.body)
            else
                raise ResponseError, "API request failed with status #{response.status}: #{response.body}"
            end
        end
    end
end
