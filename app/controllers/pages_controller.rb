class PagesController < ApplicationController
    
    def main
        client = RAWGApi::Api::Client.new
        begin
            byebug
            @games = client.index_games
            @genres = client.index_genres
            @developers = client.index_developers
            @publishers = client.index_publishers

        rescue ApiExceptions::UnauthorizedError
            @error = true
        end
   end
end
