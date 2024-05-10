class OrdersController < ApplicationController
  before_action(:authenticate_user!)
  before_action(:set_order_and_check_user, only: [:show, :edit, :update, :destroy, :delivered, :canceled])

  def index
    # <% @user_orders.each do |order|%> # NO INDEX DA PARA COLOCAR ASSIM, VER MELHOR DEPOIS
    @orders = current_user.orders
  end

  def show

  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      flash[:notice] = 'Pedido registrado com sucesso'
      redirect_to(@order)
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível registrar o pedido'
      render('new')
    end
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    if @order.update(order_params)
      flash[:notice] = 'Pedido atualizado com sucesso'
      redirect_to(@order)
    else
      flash.now[:notice] = 'Pedido não pôde ser atualizado'
      return render('edit')
    end
  end

  def destroy
    @order.destroy
    flash[:notice] = 'Pedido removido com sucesso'
    redirect_to(orders_path)
  end

  def search
    @code = params[:query]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def delivered
    @order.delivered!
    @order.order_items.each do |item|
      item.quantity.times do
        StockProduct.create!(
          order: @order,
          product_model: item.product_model,
          warehouse: @order.warehouse
        )
      end
    end
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  private

  def set_order_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      return redirect_to root_path, notice: 'Voce nao pode acessar pedido de outros usuários'
    end
  end

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end
