require 'rails_helper'

def basic_pass(path)
  username = ENV["FURIMA_AUTH_USER"] 
  password = ENV["FURIMA_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # Basic認証を経てトップページに移動する
      basic_pass root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # パンくずリストの「新規登録」の表示があることを確認する
      expect(page).to have_content('新規登録')
      # ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'last-name', with: @user.last_name
      fill_in 'first-name', with: @user.first_name
      fill_in 'last-name-kana', with: @user.furigana_last_name
      fill_in 'first-name-kana', with: @user.furigana_first_name
      find("#user_birthday_1i").find("option[value='1993']").select_option
      find("#user_birthday_2i").find("option[value='5']").select_option
      find("#user_birthday_3i").find("option[value='7']").select_option
      # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')
      # 新規登録ページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページに戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: ""
      fill_in 'email', with: ""
      fill_in 'password', with:""
      fill_in 'password-confirmation', with: ""
      fill_in 'last-name', with: ""
      fill_in 'first-name', with: ""
      fill_in 'last-name-kana', with: ""
      fill_in 'first-name-kana', with: ""
      find("#user_birthday_1i").find("option[value='']").select_option
      find("#user_birthday_2i").find("option[value='']").select_option
      find("#user_birthday_3i").find("option[value='']").select_option
      # 新規登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe "ユーザーログイン機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに遷移する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # パンくずリストの「ログイン」が表示されていることを確認する
      expect(page).to have_content('ログイン')
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password_confirmation
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # 自分のニックネームが表示されていることを確認する
      expect(page).to have_content(@user.nickname)
      # ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')
      # 新規登録ページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end  
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに遷移する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end