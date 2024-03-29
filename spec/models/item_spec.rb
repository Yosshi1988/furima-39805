require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の保存' do
    context '商品が出品できる場合' do
      it 'image、name、content、category_id、condition_id、delivery_charge_id、prefecture_id、shipping_time_id、priceが存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品が出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品画像を入力してください')
      end
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it 'nameが41文字以上では出品できない' do
        @item.name = Faker::Lorem.characters(number: rand(41..50))
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名は40文字以内で入力してください')
      end
      it 'contentが空では出品できない' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it 'contentが1001文字以上では出品できない' do
        @item.content = Faker::Lorem.characters(number: rand(1001..1100))
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明は1000文字以内で入力してください')
      end
      it 'category_idが1だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'category_idが空だと出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'condition_idが1だと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'condition_idが空だと出品できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'delivery_charge_idが1だと出品できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'delivery_charge_idが空だと出品できない' do
        @item.delivery_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'prefecture_idが1だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it 'prefecture_idが空だと出品できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it 'shipping_time_idが1だと出品できない' do
        @item.shipping_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'shipping_time_idが空だと出品できない' do
        @item.shipping_time_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'priceが空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('価格を入力してください')
      end
      it 'priceが300未満だと出品できない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
      end
      it 'priceが10000000以上だと出品できない' do
        @item.price = 10_000_100
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
      end
      it 'priceは半角数字でないと出品できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end
      it 'userが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
