json.array!(@images) do |image|
  json.extract! image, :id, :url, :width, :height, :ratio
  json.url image_url(image, format: :json)
end
