module IGDBApi
      module V4
        class Client
            include HttpStatusCodes
            include ApiExceptions

            ROOT_URL = "https://api.igdb.com/v4"
            BEARER_TOKEN = ENV['bearer_token']
            CLIENT_ID = ENV['client_id']


            #defining endpoints

            def index_games
                request(
                    http_method: :get,
                    endpoint: "/games"  
                )
            end

            def index_companies
                request(
                    http_method: :get,
                    endpoint: "/companies"
                )
            end

            def search_games(game)
                request(
                    http_method: :get,
                    endpoint: "/search/#{game}"
                )
            end

            def screenshots
                request(
                    http_method: :get,
                    endpoint: "/screenshots"
                )
            end

            private

            def connection
                @connection ||= Faraday.new(
                    url: ROOT_URL,
                    headers : {
                        'Client-ID' => "#{CLIENT_ID}"
                        "Authorization" => "Bearer #{BEARER_TOKEN}"
                    },
                )
            end

            def request(http_method:, endpoint:, params: nil, headers: nil)
                @response = connection.public_send(http_method, endpoint, params, headers)
                parsed_response = JSON.parse(@response.body)
                if @response.status == HTTP_OK_CODE
                    return parsed_response
                else
                    raise error_class
                end
            end

            def error_class
                case @response.status
                when HTTP_NOT_FOUND_CODE
                    NotFoundError
                when HTTP_UNAUTHORIZED_CODE
                    UnauthorizedError
                else
                    ApiError
                end
            end

        end
    end
end