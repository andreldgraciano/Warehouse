class OrdersController < ApplicationController
  before_action(:set_order, only: [:show, :destroy])
  before_action(:authenticate_user!)

  def index; end

  def show; end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    @order.save
    flash[:notice] = 'Pedido registrado com sucesso.'
    redirect_to(@order)
  end

  def destroy
    @order.destroy
    flash[:notice] = 'Pedido removido com sucesso!'
    redirect_to(orders_path)
  end

  private

  def set_order()
    @order = Order.find(params[:id])
  end
end
