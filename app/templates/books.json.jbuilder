# frozen_string_literal: true
json._links do
  json.self do
    json.href '/books{?author,serie}'
    json.templated true
  end
  json.author { json.href "/authors/#{author.slug}" } if author
  json.serie { json.href "/series/#{serie.slug}" } if serie
end

json._embedded do
  json.books books.each do |book|
    json.title book.title
    json._links do
      json.self { json.href "/books/#{book.slug}" }
    end
  end
end
