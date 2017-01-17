# frozen_string_literal: true
json._links do
  json.self do
    json.href '/authors'
  end
end

json._embedded do
  json.authors authors do |author|
    json.name author.name
    json._links do
      json.self do
        json.href "/authors/#{author.slug}"
      end
    end
  end
end
