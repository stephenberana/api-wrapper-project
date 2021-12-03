require 'faraday'

module RAWGApi
    module Api
        class Client
            include HttpStatusCodes
            include ApiExceptions

            BASE_URL = "https://api.rawg.io/api"
            KEY = ENV['key']
            PARAMS =  {
                key: KEY,
                page: 1,
                page_size: 10
            }
            HEADERS = {'Content-Type' => 'application/json'}

            def initialize
            end

            #defining endpoints

            def index_games
                # request(
                #     http_method: :get,
                #     endpoint: "games",
                #     params: PARAMS,
                #     headers: {'Content-Type' => 'application/json'},
                # )
                response = Faraday.get "https://api.rawg.io/api/games?key=#{KEY}&page=1&page_size=1"
                parsed_response = JSON.parse(response.body).to_a
                # parsed_response.fourth.each do |key, value|
                #     puts value
                # end
                if response.status == HTTP_OK_CODE
                    return parsed_response
                else
                    raise error_class
                end
            end

            def index_genres
                # request(
                #     http_method: :get,
                #     endpoint: "genres",
                #     params: PARAMS,
                #     headers: {'Content-Type' => 'application/json'},
                # )
                response = Faraday.get "https://api.rawg.io/api/genres?key=#{KEY}&page=1&page_size=1"
                parsed_response = JSON.parse(response.body).to_a
                if response.status == HTTP_OK_CODE
                    return parsed_response
                else
                    raise error_class
                end
            end

            def index_developers
                # request(
                #     http_method: :get,
                #     endpoint: "developers",
                #     params: PARAMS,
                #     headers: {'Content-Type' => 'application/json'},
                # )
                response = Faraday.get "https://api.rawg.io/api/developers?key=#{KEY}&page=1&page_size=1"
                parsed_response = JSON.parse(response.body).to_a
                if response.status == HTTP_OK_CODE
                    return parsed_response
                else
                    raise error_class
                end
            end

            def index_publishers
                # request(
                #     http_method: :get,
                #     endpoint: "publishers",
                #     params: PARAMS,
                #     headers: {'Content-Type' => 'application/json'},
                # )
                response = Faraday.get "https://api.rawg.io/api/publishers?key=#{KEY}&page=1&page_size=1"
                parsed_response = JSON.parse(response.body).to_a
                if response.status == HTTP_OK_CODE
                    return parsed_response
                else
                    raise error_class
                end
            end

            private

            # def connection
            #     @connection ||= Faraday.new(
            #         url: BASE_URL,
            #     )
            # end

            # def request(http_method:, endpoint:, params:, headers:)
            #     @response = connection.public_send(http_method, endpoint, params, headers)
            #     # parsed_response = JSON.parse(@response.body)
            #     if @response_status == HTTP_OK_CODE
            #         return parsed_response
            #     else
            #         raise error_class
            #     end
            # end

            def error_class
                case response.status
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