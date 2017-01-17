# frozen_string_literal: true
require 'hyperresource'

# Simple client for the api.
class Client < HyperResource
  self.root = 'http://localhost:8080'
  self.headers = { 'Accept' => 'application/hal+json',
                   'Content-Type' => 'application/json' }
end
