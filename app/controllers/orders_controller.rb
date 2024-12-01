class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @shippings_order = ShippingsOrder.new
  end

  def create
    @item = Item.find(params[:item_id])
    @shippings_order = ShippingsOrder.new(order_params)
    if @shippings_order.valid?
      @shippings_order.save
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:shippings_order).permit(:postal_code, :prefecture_id, :city, :street, :building_name,
                                            :phone_number, :user_id).merge(item_id: @item.id, user_id: current_user.id)
  end
end
