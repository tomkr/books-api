FactoryGirl.define do
  factory :author do
    name 'Test Name'
  end

  factory :book do
    title 'Test title'
    author
  end
end
