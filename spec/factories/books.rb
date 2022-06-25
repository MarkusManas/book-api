FactoryBot.define do
    factory :book do
      title { Faker::Book.title }
      isbn13  { Faker::Code.isbn(base: 13) }
    end
  end