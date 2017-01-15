json.title serie.title

json._links do
  json.self { json.href "/series/#{serie.slug}" }
  json.books { json.href "/series/#{serie.slug}/books" }
  json.first_book { json.href "/books/#{books.first.slug}" } unless
      serie.books.empty?
end
