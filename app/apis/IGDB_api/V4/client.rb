require 'faraday'

module IGDBApi
      module V4
        class Client
            include HttpStatusCodes
            include ApiExceptions

            ROOT_URL = "https://api.igdb.com/v4"
            BEARER_TOKEN = ENV['bearer_token']
            CLIENT_ID = ENV['client_id']

            def initialize
            end

            #defining endpoints

            def index_games
                request(
                    http_method: :get,
                    endpoint: "/games",
                    params: {
                        fields: 'name,summary,total_rating_count,url',
                        limit: 10,
                    },
                    headers: {
                        "Client-ID" => "#{CLIENT_ID}",
                        "Authorization" => "Bearer #{BEARER_TOKEN}"
                    },
                )
            end

            def index_companies
                request(
                    http_method: :get,
                    endpoint: "/companies",
                    params: {
                        fields: 'name,description,url',
                        limit: 10,
                    },
                    headers: {
                        "Client-ID" => "#{CLIENT_ID}",
                        "Authorization" => "Bearer #{BEARER_TOKEN}"
                    },
                )
            end

            def index_platforms
                request(
                    http_method: :get,
                    endpoint: "/platforms",
                    params: {
                        fields: "name,description,url",
                        limit: 10,
                    },
                    headers: {
                        "Client-ID" => "#{CLIENT_ID}",
                        "Authorization" => "Bearer #{BEARER_TOKEN}"
                    },
                )
            end

           def search_game
                request(
                    http_method: :get,
                    endpoint: "/search",
                    params: {
                        field: "*",
                        search: "Fatal Frame",
                        limit: 20,
                    },
                    headers: {
                        "Client-ID" => "#{CLIENT_ID}",
                        "Authorization" => "Bearer #{BEARER_TOKEN}"
                    },
                )
           end

            private

            def connection
                @connection ||= Faraday.new(
                    url: ROOT_URL,
                    headers: {
                        'Client-ID' => "#{CLIENT_ID}",
                        'Authorization' => "Bearer #{BEARER_TOKEN}"
                    },
                )
            end

            def request(http_method:, endpoint:, params:, headers:)
                @response = connection.public_send(http_method, endpoint, params, headers)
                parsed_response = JSON.parse(@response.body)
                if @response.status == HTTP_OK_CODE
                    return parsed_response
                else
                    raise error_class
                end
            end

            def headers
                'Client-ID' => "#{CLIENT_ID}",
                'Authorization' => "Bearer #{BEARER_TOKEN}"
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