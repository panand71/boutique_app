json.array!(@boutique_searches) do |boutique_search|
  json.extract! boutique_search, :id, :keywords, :boutique_id, :boutique_name, :category, :city, :state, :new, :show
  json.url boutique_search_url(boutique_search, format: :json)
end
