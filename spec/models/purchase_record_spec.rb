require 'rails_helper'
describe PurchaseRecord do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    @purchase_record = FactoryBot.build(:purchase_record, user_id: @user.id, item_id: @item.id)
    sleep(1)
  end

  describe '商品購入機能' do
    context '商品購入がうまくいくとき' do
      it "全ての値（token含む）が正しく入力されていれば商品の購入ができること" do
        expect(@purchase_record).to be_valid
      end
      it "bilding_nameが空でも商品の購入ができること" do
        @purchase_record.building_name = nil
        expect(@purchase_record).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it "postal_codeが空だと購入できないこと" do
        @purchase_record.postal_code = nil
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("郵便番号を入力してください")
      end
      it "postal_codeが半角のハイフンを含んだ正しい形式でないと購入できないこと" do
        @purchase_record.postal_code = "2270066"
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it "prefecture_idが空だと購入できない" do
        @purchase_record.prefecture_id = nil
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("都道府県を入力してください")
      end
      it "prefecture_idが1だと購入できないこと" do
        @purchase_record.prefecture_id = 1
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("都道府県は1以外の値にしてください")
      end
      it "cityが空だと購入できないこと" do
        @purchase_record.city = nil
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("市区町村を入力してください")
      end
      it "house_numberが空だと購入できないこと" do
        @purchase_record.house_number = nil
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("番地を入力してください")
      end
      it "phone_numberが空だと購入できないこと" do
        @purchase_record.phone_number = nil
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("電話番号を入力してください")
      end
      it "phone_numberは12桁以上だと購入できないこと" do
        @purchase_record.phone_number = "123456789012"
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end
      it "phone_numberは全角数字だと購入できないこと" do
        @purchase_record.phone_number = "１２３４５６７８９０１"
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("電話番号は不正な値です")
      end
      it "userが紐付いていないと購入できないこと" do
        @purchase_record.user_id = nil
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("ユーザーを入力してください")
      end
      it "itemが紐付いていないと購入できない" do
        @purchase_record.item_id = nil
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("商品を入力してください")
      end
      it "tokenが空では登録できないこと" do
        @purchase_record.token = nil
        @purchase_record.valid?
        expect(@purchase_record.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end


