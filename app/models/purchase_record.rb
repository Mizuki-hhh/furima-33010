class PurchaseRecord
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city, format: {with: /\A[ぁ-んァ-ン一-龥]/}
    validates :house_number
    validates :phone_number, format: {with: /\A[0-9]+\z/} 
  end

  def save
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, user_id: user.id)
    Record.create(user_id: user.id, item_id: item.id)
  end
end