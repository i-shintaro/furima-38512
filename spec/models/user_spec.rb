require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての項目の入力が適切にされたら登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意でないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)は、名字と名前がないと登録できない' do
        @user.last_name = ''
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "First name can't be blank")
      end

      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）がないと登録できない' do
        @user.last_name = 'rikutaro'
        @user.first_name = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.',
                                                      'Last name is invalid. Input full-width characters.')
      end

      it 'お名前カナ(全角)は、名字と名前がないと登録できない' do
        @user.last_name_kana = ''
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "First name kana can't be blank")
      end

      it 'お名前カナ(全角)は、全角（カタカナ)がないと登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.first_name_kana = 'タロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')

        @user.last_name_kana = 'ヤマダ'
        @user.first_name_kana = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
      end
      it '生年月日がないと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
