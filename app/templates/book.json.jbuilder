# frozen_string_literal: true
json.title book.title

json._links do
  json.self { json.href "/books/#{book.slug}" }
  json.author { json.href "/authors/#{book.author.slug}" }
  if book.serie
    json.serie { json.href "/series/#{book.serie.slug}" }
    json.prev { json.href "/books/#{book.prev.slug}" } if book.prev
    json.next { json.href "/books/#{book.next.slug}" } if book.next
  end
end
