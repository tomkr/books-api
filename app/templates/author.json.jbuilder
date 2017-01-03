json.name author.name

json._links do
  json.self do
    json.href "/authors/#{author.id}"
  end
end
