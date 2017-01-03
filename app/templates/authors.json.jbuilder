json._links do
  json.self do
    json.href '/authors'
  end
end

json._embedded do
  json.authors authors, :name
end
