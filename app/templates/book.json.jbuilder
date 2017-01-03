json.title book.title

json._links do
  json.self do
    json.href "/books/#{book.id}"
  end
end
