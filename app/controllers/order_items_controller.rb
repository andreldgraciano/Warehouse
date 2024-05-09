class OrderItemsController < ApplicationController
  before_action :set_order, only: [:new, :create]

  def new
    @products = @order.supplier.product_models
    @order_item = OrderItem.new
  end

  def create
    # @order_item = OrderItem.new(order_item_params)
    # @order_item.order = @order
    # @order_item.save
    # da forma abaixo ele ja cria o order_item vinculado ao order.
    @order.order_items.create(order_item_params)
    redirect_to @order, notice: 'Item adicionado com sucesso'
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def order_item_params
    params.require(:order_item).permit(:product_model_id, :quantity)
  end
end
