class OrdersController < ApplicationController
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    @shippings_order = ShippingsOrder.new
  end

  def create
    @item = Item.find(params[:item_id])
    @shippings_order = ShippingsOrder.new(order_params)
    if @shippings_order.valid?
      pay_item
      @shippings_order.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:shippings_order).permit(:postal_code, :prefecture_id, :city, :street, :building_name,
                                            :phone_number, :user_id).merge(item_id: @item.id, user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
