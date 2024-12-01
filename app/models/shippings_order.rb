class ShippingsOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street, :building_name, :phone_number, :order_id, :item_id, :user_id

  with_options presence: true do
    validates :user_id
    validates :postal_code
    validates :city
    validates :street
    validates :phone_number
  end

  def save
    order = Order.create(item_id:, user_id:)
    Shipping.create(postal_code:, prefecture_id:, city:, street:, building_name:, phone_number:,
                    order_id: order.id)
  end
end
