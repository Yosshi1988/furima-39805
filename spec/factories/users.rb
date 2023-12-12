FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.email }
    password { "p1#{Faker::Internet.password(min_length: 6)}" }
    password_confirmation { password }
    last_name { person.last.kanji }
    first_name { person.first.kanji }
    kana_last_name { person.last.katakana }
    kana_first_name { person.first.katakana }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 80) }
  end
end
