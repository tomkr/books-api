# Function to easily create slugs.
module Sluggify
  def sluggify(name)
    name.downcase.strip.tr(' ', '-').gsub(/[^\w-]/, '')
  end
end
