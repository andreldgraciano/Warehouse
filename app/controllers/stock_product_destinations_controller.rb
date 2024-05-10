class StockProductDestinationsController < ApplicationController
  def create
    warehouse = Warehouse.find(params[:warehouse_id])
    product_model = Warehouse.find(params[:product_model_id])
    stock_product = StockProduct.find_by(warehouse: warehouse, product_model: product_model)

    if stock_product
      recipient = params[:recipient]
      address = params[:address]
      stock_product.create_stock_product_destination!(recipient: recipient, address: address)

      redirect_to warehouse, notice: 'Item retirado com sucesso'
    end
  end
end
