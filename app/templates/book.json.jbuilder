# frozen_string_literal: true
json.title book.title

json._links do
  json.self { json.href "/books/#{book.slug}" }
  json.author { json.href "/authors/#{book.author.slug}" }
  json.serie { json.href "/series/#{book.serie.slug}" } if book.serie
end
