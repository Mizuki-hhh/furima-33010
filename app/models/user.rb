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
    validates :password_confirmation, presence: true
    PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/.freeze
    validates_format_of :password, :password_confirmation,  with: PASSWORD_REGEX 
    NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze
    validates_format_of :last_name, :first_name, with: NAME_REGEX
    FURIGANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
    validates_format_of :furigana_last_name, :furigana_first_name, with: FURIGANA_REGEX

end
