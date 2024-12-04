class ShippingsOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street, :building_name, :phone_number, :order_id, :item_id, :user_id, :token

  with_options presence: true do
    validates :user_id
    validates :token, presence: true
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'must be between 10 to 11 digits' }
  end

  def save
    order = Order.create(item_id:, user_id:)
    Shipping.create(postal_code:, prefecture_id:, city:, street:, building_name:, phone_number:,
                    order_id: order.id)
  end
end
