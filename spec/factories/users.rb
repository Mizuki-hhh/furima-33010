FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}
    furigana_last_name {Faker::Name.last_name}
    furigana_first_name {Faker::Name.first_name}
    birthday {Faker::Date.birthday(min_age: 5, max_age: 90)}
  end
end