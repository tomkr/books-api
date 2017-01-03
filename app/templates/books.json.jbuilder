json._links do
  json.self do
    json.href '/books'
  end
end

json._embedded do
  json.books books, :title
end
