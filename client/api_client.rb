# frozen_string_literal: true
require 'hyperresource'

# Wrapper for the API used by the CLI.
class APIClient < HyperResource
  self.root = 'http://localhost:8080'
  self.headers = { 'Content-Type' => 'application/json',
                   'Accept' => 'application/hal+json' }
end
