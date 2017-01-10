json.name author.name

json._links do
  json.self do
    json.href "/authors/#{author.slug}"
  end
  json.books do
    json.href "/authors/#{author.slug}/books"
  end
end
