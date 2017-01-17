json.username user.username
json.jwt 'token'

json._links do
  json.self { json.href "/users/#{user.username}" }
end
