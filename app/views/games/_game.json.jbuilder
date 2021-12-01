json.extract! game, :id, :name, :summary, :storyline, :rating_count, :created_at, :updated_at
json.url game_url(game, format: :json)
