class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    validates :nickname, presence: true
    validates :last_name, presence: true
    validates :first_name, presence: true
    validates :furigana_last_name, presence: true
    validates :furigana_first_name, presence: true
    validates :birthday, presence: true
    validates :email, uniqueness: true
    validates :encrypted_password_confirmation, presence: true
    PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/.freeze
    validates_format_of :encrypted_password, with: PASSWORD_REGEX, message: '半角英数字混合で設定してください' 
    NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze
    validates_format_of :last_name, :first_name, with: NAME_REGEX, message: '全角（漢字・ひらがな・カタカナ）で設定してください' 
    FURIGANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
    validates_format_of :furigana_last_name, :furigana_first_name, with: FURIGANA_REGEX, message: '全角（カタカナ）で設定してください' 

end
