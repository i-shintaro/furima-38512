class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_owner, only: [:index, :create]
  before_action :redirect_if_purchased_or_not_owner, only: [:index]
  def index
    setup_gon_public_key
    @shippings_order = ShippingsOrder.new
  end

  def create
    @shippings_order = ShippingsOrder.new(order_params)
    if @shippings_order.valid?
      pay_item
      @shippings_order.save
      redirect_to root_path
    else
      setup_gon_public_key
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:shippings_order).permit(:postal_code, :prefecture_id, :city, :street, :building_name, :phone_number)
          .merge(item_id: @item.id, user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def redirect_if_owner
    return unless @item.user_id == current_user.id

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def setup_gon_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def redirect_if_purchased_or_not_owner
    return unless @item.order.present? || @item.user_id == current_user.id

    redirect_to root_path
  end
end
