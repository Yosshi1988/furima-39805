require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    item = FactoryBot.create(:item)
    another_user = FactoryBot.create(:user)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: another_user.id, item_id: item.id)
  end

  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end
      it 'buildingが空でも保存できること' do
        @purchase_address.building = ''
        expect(@purchase_address).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('郵便番号を入力してください')
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('郵便番号はハイフン(-)を含む半角数字で入力してください')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @purchase_address.prefecture_id = '1'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('都道府県を選択してください')
      end
      it 'cityが空だと保存できないこと' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('市区町村を入力してください')
      end
      it 'street_addressが空だと保存できないこと' do
        @purchase_address.street_address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('番地を入力してください')
      end
      it 'telが空だと保存できないこと' do
        @purchase_address.tel = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号を入力してください')
      end
      it 'telが半角数字でないと保存できないこと' do
        @purchase_address.tel = '０９０１２３４５６７８'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は10桁または11桁の半角数字で入力してください')
      end
      it 'telが9文字以下だと保存できないこと' do
        @purchase_address.tel = '090123456'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は10桁または11桁の半角数字で入力してください')
      end
      it 'telが12文字以上だと保存できないこと' do
        @purchase_address.tel = '090123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は10桁または11桁の半角数字で入力してください')
      end
      it 'tokenが空だと保存できないこと' do
        @purchase_address.token = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('クレジットカード情報を入力してください')
      end
      it 'userが紐付いていないと保存できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Userを入力してください')
      end
      it 'itemが紐付いていないと保存できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
