json.title serie.title

json._links do
  json.self { json.href "/series/#{serie.id}" }
  json.books { json.href "/series/#{serie.id}/books" }
  json.first_book { json.href "/books/#{books.first.id}" }
end
