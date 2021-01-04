require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nickname、email、password、password_confirmaiton、名前（全角かな・カナ・漢字）、フリガナ（全角カナ）、birthdayが正しく存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "emailが空だと登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "emailに@が含まれていない場合登録できない" do
        @user.email = "testgmail.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it "passwordが空だと登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "passwordが5文字以下だと登録できない" do
        @user.password = "000aa"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it "passwordは半角数字だけだと登録できない" do
        @user.password = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "passwordは半角英字だけだと登録できない" do
        @user.password = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "passwordが存在してもpassword_confirmationが空だと登録できない" do
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）を入力してください")
      end
      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = "123abc"
        @user.password_confirmation = "123abcd"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "ユーザーの本名は名字が空だと登録できない" do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end
      it "ユーザーの本名は名前が空だと登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it "ユーザー本名は、名字が半角では登録できない" do
        @user.last_name = "ﾋｶﾞｼｼﾀ"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字は不正な値です")
      end
      it "ユーザー本名は、名前が半角では登録できない" do
        @user.first_name = "ﾐｽﾞｷ"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は不正な値です")
      end
      it "ユーザー本名は、名字が全角英字では登録できない" do
        @user.last_name = "ｈｉｇａｓｈｉ"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字は不正な値です")
      end
      it "ユーザー本名は、名前が全角英字では登録できない" do
        @user.first_name = "ｍｉｚｕｋｉ"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は不正な値です")
      end
      it "ユーザー本名は、名字が半角英字では登録できない" do
        @user.last_name = "higashi"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字は不正な値です")
      end
      it "ユーザー本名は、名前が半角英字では登録できない" do
        @user.first_name = "mizuki"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は不正な値です")
      end
      it "ユーザー本名のフリガナは名字が空だと登録できない" do
        @user.furigana_last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ（名字）を入力してください")
      end
      it "ユーザー本名のフリガナは名前が空だと登録できない" do
        @user.furigana_first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ（名前）を入力してください")
      end
      it "ユーザー本名のフリガナは、名字が半角カナでは登録できない" do
        @user.furigana_last_name = "ﾋｶﾞｼｼﾀ"
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ（名字）は不正な値です")
      end
      it "ユーザー本名のフリガナは、名前が半角カナでは登録できない" do
        @user.furigana_first_name = "ﾐｽﾞｷ"
        @user.valid?
        expect(@user.errors.full_messages).to include("フリガナ（名前）は不正な値です")
      end
      it "birthdayが空では登録できない" do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end