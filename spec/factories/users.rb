FactoryBot.define do
  factory :user do
    nickname { Faker::Name.initials }
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { password }
    first_name { '陸太郎' }
    last_name { '山田' }
    first_name_kana { 'リクタロウ' }
    last_name_kana { 'ヤマダ' }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
