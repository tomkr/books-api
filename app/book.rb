require 'webmachine'

# A webmachine resource representing a book.
class Book < Webmachine::Resource
  def to_html
    '<html><body>title</html></body>'
  end
end
