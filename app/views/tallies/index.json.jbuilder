json.array!(@tallies) do |tally|
  json.extract! tally, :id, :, :integer, :, :integer, :, :integer, :, :integer, :, :integer, :, :string
  json.url tally_url(tally, format: :json)
end
