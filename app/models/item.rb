class Item < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :shipping_date

  with_options presence: true do
    validates :name
    validates :explanation
    validates :image
    validates :category_id
    validates :condition_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :shipping_date_id
  end

  validates :category_id,        numericality: { other_than: 1 }
  validates :condition_id,       numericality: { other_than: 1 }
  validates :prefecture_id,      numericality: { other_than: 1 }
  validates :shipping_charge_id, numericality: { other_than: 1 }
  validates :shipping_date_id,   numericality: { other_than: 1 }
  validates :category_id,        numericality: { other_than: 1 }

  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price
  end

  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10000000 }

end