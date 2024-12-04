require 'rails_helper'

RSpec.describe ShippingsOrder, type: :model do
  before do
    user = FactoryBot.create(:user)
    @shippings_order = FactoryBot.build(:shippings_order, user_id: user.id)
  end

  describe '購入機能保存' do
    context '登録情報に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@shippings_order).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @shippings_order.building_name = ''
        expect(@shippings_order).to be_valid
      end
    end

    context '商品が購入（保存）できない場合' do
      it 'tokenが空では登録できないこと' do
        @shippings_order.token = nil
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeが空だと保存できないこと' do
        @shippings_order.postal_code = ''
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @shippings_order.postal_code = '1234567'
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefectureを選択していないと保存できないこと' do
        @shippings_order.prefecture_id = 1
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        @shippings_order.city = ''
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include("City can't be blank")
      end

      it 'streetが空だと保存できないこと' do
        @shippings_order.street = ''
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include("Street can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @shippings_order.phone_number = ''
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下だと保存できないこと' do
        @shippings_order.phone_number = '090123456'
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include('Phone number must be between 10 to 11 digits')
      end

      it 'phone_numberが12桁以上だと保存できないこと' do
        @shippings_order.phone_number = '090123456789'
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include('Phone number must be between 10 to 11 digits')
      end

      it 'phone_numberに数字以外の文字が含まれている場合は保存できないこと' do
        @shippings_order.phone_number = '090-1234-5678'
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include('Phone number must be between 10 to 11 digits')
      end

      it 'phone_numberが全角数字だと保存できないこと' do
        @shippings_order.phone_number = '０９０１２３４５６７８'
        @shippings_order.valid?
        expect(@shippings_order.errors.full_messages).to include('Phone number must be between 10 to 11 digits')
      end
    end
  end
end
