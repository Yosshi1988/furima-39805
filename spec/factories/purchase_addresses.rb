FactoryBot.define do
  factory :purchase_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '中央区' }
    street_address { 'テスト1-1-1' }
    building { 'テストハイツ101' }
    tel { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
