# frozen_string_literal: true
json._links do
  json.self { json.href '/series' }
end

json._embedded do
  json.series series.each do |serie|
    json.title serie.title
    json._links do
      json.self { json.href "/series/#{serie.slug}" }
    end
  end
end
