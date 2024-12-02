FactoryBot.define do
  factory :shippings_order do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '大阪市' }
    street { '難波' }
    building_name { 'なんなんビル' }
    phone_number { '09037106709' }
  end
end
