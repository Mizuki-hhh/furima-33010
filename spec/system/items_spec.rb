require 'rails_helper'

def basic_pass(path)
  username = ENV["FURIMA_AUTH_USER"] 
  password = ENV["FURIMA_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "商品出品機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end
  context '商品を出品できるとき' do
    it 'ログインしたユーザーは新規登録できること' do
      # Basic認証を経てトップページへ遷移する
      basic_pass root_path
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品出品ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')
      # 商品出品ページに移動する
      visit new_item_path
      # パンくずリストの「商品出品」が表示されていることを確認する
      expect(page).to have_content('商品出品')
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # 画像選択フォームに画像を添付する
      attach_file('item[images][]', image_path)
      # 画像以外のフォームに情報を入力する
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.explanation
      find("#item-category").find("option[value='2']").select_option
      find("#item-sales-status").find("option[value='2']").select_option
      find("#item-shipping-fee-status").find("option[value='2']").select_option
      find("#item-prefecture").find("option[value='2']").select_option
      find("#item-scheduled-delivery").find("option[value='2']").select_option
      fill_in 'item-price', with: @item.price
      # 送信すると、Itemモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど出品した商品が表示されていることを確認する（画像）
      expect(page).to have_selector("img")
      # トップページには先ほど出品した商品が表示されていることを確認する（商品名）
      expect(page).to have_content(@item.name)
      # トップページには先ほど出品した商品が表示されていることを確認する（価格）
      expect(page).to have_content(@item.price)
      # トップページには先ほど出品した商品が表示されていることを確認する（配送料の負担）
      expect(page).to have_content(@item.shipping_charge_id)
      # 
    end
  end
  context '商品を出品できないとき' do
    it 'ログインしていないと商品ん出品ページに遷移できないこと' do
      # トップページに遷移する
      visit root_path
      # 商品出品ページへのボタンをクリックすると、ログインページに遷移する
      click_on ('出品する')
      expect(current_path).to eq new_user_session_path
    end
    it '送信する出品情報が空のため、メッセージの送信に失敗すること' do
      # トップページに遷移する
      visit root_path
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password_confirmation
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品出品ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')
      # 商品出品ページに移動する
      visit new_item_path
      # フォームに情報を入力しない
      fill_in 'item-name', with: ''
      fill_in 'item-info', with: ''
      find("#item-category").find("option[value='1']").select_option
      find("#item-sales-status").find("option[value='1']").select_option
      find("#item-shipping-fee-status").find("option[value='1']").select_option
      find("#item-prefecture").find("option[value='1']").select_option
      find("#item-scheduled-delivery").find("option[value='1']").select_option
      fill_in 'item-price', with: ''
      # 送信してもItemモデルのカウントが上がらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.not_to change { Item.count }
      # 出品ページに留まることを確認する
      expect(current_path).to eq '/items'
    end
  end
end

RSpec.describe "商品編集機能" do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '商品編集ができるとき' do
    it 'ログインしたユーザーは自分が出品した商品の編集ができる' do
      # Basic認証を経てトップページにいる
      basic_pass root_path
      # 商品1を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品詳細ページへ移動する
      visit item_path(@item1)
      # 商品1に編集ボタンがあることを確認する
      expect(page).to have_content('商品の編集')
      # 編集ページへ遷移する
      visit edit_item_path(@item1)
      # パンくずリストの「商品編集」が表示されていることを確認する
      expect(page).to have_content('商品編集')
      # すでに投稿（出品）済みの情報がフォームに入っていることを確認する
      expect(
        find('#item-name').value
      ).to eq @item1.name
      expect(
        find('#item-info').value
      ).to eq @item1.explanation
      expect(
        find('#item-category').value
      ).to eq "#{@item1.category_id}"
      expect(
        find('#item-sales-status').value
      ).to eq "#{@item1.condition_id}"
      expect(
        find('#item-shipping-fee-status').value
      ).to eq "#{@item1.shipping_charge_id}"
      expect(
        find('#item-prefecture').value
      ).to eq "#{@item1.prefecture_id}"
      expect(
        find('#item-scheduled-delivery').value
      ).to eq "#{@item1.shipping_date_id}"
      expect(
        find('#item-price').value
      ).to eq "#{@item1.price}"
      # 出品内容を編集する
      image2_path = Rails.root.join('public/images/test_image2.png')
      attach_file('item[images][]', image2_path)
      fill_in 'item-name', with: "#{@item1.name}+編集した商品名"
      fill_in 'item-info', with: "#{@item1.explanation}+編集した商品説明"
      find("#item-category").find("option[value='3']").select_option
      find("#item-sales-status").find("option[value='3']").select_option
      find("#item-shipping-fee-status").find("option[value='3']").select_option
      find("#item-prefecture").find("option[value='3']").select_option
      find("#item-scheduled-delivery").find("option[value='3']").select_option
      fill_in 'item-price', with: @item1.price
      # 編集してもItemモデルのカウントは変わらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)
      # 商品詳細ページに遷移したことを確認する
      expect(current_path).to eq item_path(@item1)
      # 詳細商品ページには先ほど変更した商品の情報が存在することを確認する（画像）
      expect(page).to have_selector("img")
      # 詳細商品ページには先ほど変更した商品の情報が存在することを確認する（テキスト情報）
      expect(page).to have_content("#{@item1.name}+編集した商品名")
      expect(page).to have_content("#{@item1.explanation}+編集した商品説明")
      # 詳細商品ページには先ほど変更した商品の情報が存在することを確認する（プルダウン選択）
      expect(page).to have_content(@item1.category_id)
      expect(page).to have_content(@item1.condition_id)
      expect(page).to have_content(@item1.shipping_charge_id)
      expect(page).to have_content(@item1.prefecture_id)
      expect(page).to have_content(@item1.shipping_date_id)
      # 詳細商品ページには先ほど変更した商品の情報が存在することを確認する（価格）
      expect(page).to have_content(@item1.price)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容の商品が存在することを確認する（画像）
      expect(page).to have_selector("img")
      # トップページには先ほど変更した内容の商品が存在することを確認する（商品名）
      expect(page).to have_content(@item1.name)
      # トップページには先ほど変更した内容の商品が存在することを確認する（価格）
      expect(page).to have_content(@item1.price)
      # トップページには先ほど変更した内容の商品が存在することを確認する（配送料の負担）
      expect(page).to have_content(@item1.shipping_charge_id)
    end
  end
  context '商品編集ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の編集画面には遷移できない' do
      # 商品1を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品2の商品ページへ移動する
      visit item_path(@item2)
      # 商品2に編集ボタンがないことを確認する
      expect(page).to have_no_content('商品の編集')
    end
    it 'ログインしていないと商品の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 商品1の詳細ページへ移動する
      visit item_path(@item1)
      # 商品1に編集ボタンがないことを確認する
      expect(page).to have_no_content('商品の編集')
      # トップページにいる
      visit root_path
      # 商品2の詳細ページへ移動する
      visit item_path(@item2)
      # 商品2に編集ボタンがないことを確認する
      expect(page).to have_no_content('商品の編集')
    end
  end
end

