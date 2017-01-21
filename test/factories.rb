# frozen_string_literal: true
FactoryGirl.define do
  factory :author do
    sequence(:name) { |i| "Test name #{i}" }
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

  factory :user do
    username 'test'
    password 'password'
  end
end
