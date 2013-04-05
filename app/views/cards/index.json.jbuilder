json.array!(@cards) do |card|
  json.extract! card, :num, :note
  json.url card_url(card, format: :json)
end