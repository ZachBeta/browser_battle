json.array!(@games) do |game|
  json.extract! game, :current_player_id, :other_player_id
  json.url game_url(game, format: :json)
end
