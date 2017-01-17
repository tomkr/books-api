# frozen_string_literal: true
json.username user.username
json.jwt jwt

json._links do
  json.self { json.href "/users/#{user.username}" }
end
