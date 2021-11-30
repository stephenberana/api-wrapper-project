class PagesController < ApplicationController
   def main
        client = IGDBApi::V4::Client.new 
        begin
            @games = client.index_games
            @companies = client.index_companies
            @game_instance = client.search_games
            @screenshot = client.screenshots

        rescue => ApiExceptions::UnauthorizedError
            @error = true
        end
   end
end
