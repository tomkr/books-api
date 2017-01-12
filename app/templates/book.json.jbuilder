json.title book.title

json._links do
  json.self { json.href "/books/#{book.slug}" }
  json.serie { json.href "/series/#{book.serie.id}" } if book.serie
end
