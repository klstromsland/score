json.array!(@entrants) do |entrant|
  json.extract! entrant, :id, :first_name, :last_name, :idnumber, :dog_name, :dogidnumber, :breed
  json.url entrant_url(entrant, format: :json)
end
