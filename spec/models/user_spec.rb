require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemailとpasswordとpassword_confirmationとlast_nameとfirst_nameとkana_last_nameとkana_first_nameとbirth_dateが存在すれば登録できる' do # rubocop:disable Layout/LineLength
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'p123456'
        @user.password_confirmation = 'p1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'passwordが半角数字のみの場合は登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには半角英字と半角数字の両方を含めて設定してください')
      end
      it 'passwordが半角英字のみの場合は登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには半角英字と半角数字の両方を含めて設定してください')
      end
      it 'passwordが全角の場合は登録できない' do
        @user.password = 'ｐ１２３４５６'
        @user.password_confirmation = 'ｐ１２３４５６'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには半角英字と半角数字の両方を含めて設定してください')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'p1234'
        @user.password_confirmation = 'p1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 130, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字を入力してください')
      end
      it 'last_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'Tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字には全角かな/カナ漢字のみ使用できます')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前を入力してください')
      end
      it 'first_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'Ichiro'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前には全角かな/カナ漢字のみ使用できます')
      end
      it 'kana_last_nameが空では登録できない' do
        @user.kana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)を入力してください')
      end
      it 'kana_last_nameは全角カナでないと登録できない' do
        @user.kana_last_name = 'たなか'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)には全角カナのみ使用できます')
      end
      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前(カナ)を入力してください')
      end
      it 'kana_first_nameは全角カナでないと登録できない' do
        @user.kana_first_name = 'いちろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前(カナ)には全角カナのみ使用できます')
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
