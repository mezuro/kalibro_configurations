json.array!(@reading_groups) do |reading_group|
  json.extract! reading_group, :id, :name, :description
  json.url reading_group_url(reading_group, format: :json)
end
