class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :password_confirmation
  end

  validates :email, uniqueness: true
    
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
