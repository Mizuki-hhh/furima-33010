FactoryBot.define do
  factory :purchase_record do
    postal_code {'227-0066'}
    prefecture_id { 2 }
    city { '横浜市青葉区' }
    house_number { '青山1-1' }
    building_name { 'あかね' }
    phone_number { '09048186876' }
    association :item
    user {item.user}
    
  end
end

