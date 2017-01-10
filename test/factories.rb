FactoryGirl.define do
  factory :author do
    name 'Test Name'
    sequence(:slug) { |i| "test-name-#{i}" }
  end

  factory :book do
    title 'Test title'
    sequence(:slug) { |i| "test-title-#{i}" }
    author
  end

  factory :serie do
    title 'Test serie title'
    slug 'test-serie-title'
  end
end
