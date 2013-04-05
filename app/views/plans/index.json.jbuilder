json.array!(@plans) do |plan|
  json.extract! plan, :title
  json.url plan_url(plan, format: :json)
end