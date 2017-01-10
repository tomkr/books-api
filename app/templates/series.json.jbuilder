json._links do
  json.self do
    json.href self_link
  end
end

json._embedded do
  json.series series.each do |serie|
    json.title serie.title
    json._links do
      json.self { json.href "/series/#{serie.id}" }
    end
  end
end
