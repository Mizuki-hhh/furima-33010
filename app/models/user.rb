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

    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
    validates_format_of :password, :password_confirmation,  with: PASSWORD_REGEX 
    
    with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ } do
      validates :first_name
      validates :last_name
    end
    with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } do
      validates :furigana_last_name
      validates :furigana_first_name
    end


end
