json._links do
  json.self do
    json.href self_link
  end
end

json._embedded do
  json.books books, :title
end
