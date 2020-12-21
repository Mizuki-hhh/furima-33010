require 'rails_helper'
describe Item do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品ができるとき' do
      it "商品の画像、名前、説明、カテゴリー情報、商品の状態、配送料の負担、配送元の地域、発送までの日数、価格について適切に記入すると商品を出品できる" do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができないとき' do
      it "商品の画像がないと商品を出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "商品名がないと商品を出品できない" do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "商品の説明がないと商品を出品できない" do
        @item.explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it "カテゴリーの情報がないと商品を出品できない" do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "商品の状態についての情報がないと商品を出品できない" do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it "配送料の負担についての情報がないと商品を出品できない" do
        @item.shipping_charge_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge can't be blank")
      end
      it "発送元の地域についての情報がないと商品を出品できない" do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "発送までの日数についての情報がないと商品を出品できない" do
        @item.shipping_date_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank")
      end
      it "価格についての情報がないと商品を出品できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "価格の範囲が300円未満だと商品を出品できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than 299")
      end
      it "価格の範囲が10,000,000以上だと商品を出品できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than 10000000")
      end
      it "販売価格が全角数字だと商品を出品できない" do
        @item.price = "５５５"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "" do
      end
      it "" do
      end
      it "" do
      end
      it "" do
      end
      it "" do
      end
      it "" do
      end
      it "" do
      end
    end
  end

end
