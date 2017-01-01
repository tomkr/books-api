require 'webmachine'

# A webmachine resource representing a book.
class Book < Webmachine::Resource
  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def to_json
    {
      title: 'Title',
      _links: {
        self: {
          href: "/books/#{request.path_info[:id]}"
        }
      }
    }.to_json
  end
end
