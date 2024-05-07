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
    if @order.save
      flash[:notice] = 'Pedido registrado com sucesso.'
      redirect_to(@order)
    else
      flash.now[:notice] = 'Data prevista de entrega deve ser maior que hoje'
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      return render('new')
    end
  end

  def destroy
    @order.destroy
    flash[:notice] = 'Pedido removido com sucesso!'
    redirect_to(orders_path)
  end

  def search
    @code = params[:query]

    @order = Order.find_by(code: @code)
  end

  private

  def set_order()
    @order = Order.find(params[:id])
  end
end
