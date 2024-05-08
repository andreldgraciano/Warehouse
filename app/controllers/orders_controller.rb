class OrdersController < ApplicationController
  before_action(:authenticate_user!)
  before_action(:set_order_and_check_user, only: [:show, :edit, :update, :destroy])

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
      flash[:notice] = 'Pedido registrado com sucesso.'
      redirect_to(@order)
    else
      flash.now[:notice] = 'Data prevista de entrega deve ser maior que hoje'
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      return render('new')
    end
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    if @order.update(order_params)
      flash[:notice] = 'Pedido atualizado com sucesso!'
      redirect_to(@order)
    else
      flash.now[:notice] = 'Pedido não pôde ser atualizado.'
      return render('edit')
    end
  end

  def destroy
    @order.destroy
    flash[:notice] = 'Pedido removido com sucesso!'
    redirect_to(orders_path)
  end

  def search
    @code = params[:query]

    @orders = Order.where("code LIKE ?", "%#{@code}%")
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
