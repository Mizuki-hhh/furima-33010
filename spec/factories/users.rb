FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}

    last_name {"東下"}
    first_name {"瑞季"}
    furigana_last_name {"ヒガシシタ"}
    furigana_first_name {"ミズキ"}
    birthday {"1993-05-07"}
  end
end