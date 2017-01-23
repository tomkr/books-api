# frozen_string_literal: true
json._links do
  json.self { json.href '/' }
  json.books do
    json.href '/books{?author,serie}'
    json.templated true
  end
  json.authors { json.href '/authors' }
  json.series { json.href '/series' }
  json.signup { json.href '/signup' }
  json.signin { json.href '/signin' }
  json.user do
    json.href '/users/{username}'
    json.templated true
  end
end
