json._links do
  json.self do
    json.href self_link
  end
end

json._embedded do
  json.books books.each do |book|
    json.title book.title
    json._links do
      json.self { json.href "/books/#{book.id}" }
    end
  end
end
