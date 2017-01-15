# Function to easily create slugs.
module Sluggify
  def self.sluggify(name)
    return '' if name.blank?
    name.downcase.strip.tr(' ', '-').gsub(/[^\w-]/, '')
  end
end
