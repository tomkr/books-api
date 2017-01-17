# frozen_string_literal: true
json._links do
  json.self { json.href '/' }
  json.books { json.href '/books' }
  json.authors { json.href '/authors' }
end
