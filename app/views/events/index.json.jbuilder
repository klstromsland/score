json.array!(@events) do |event|
  json.extract! event, :id, :title, :place, :date, :status, :first, :, :third
  json.url event_url(event, format: :json)
end
