class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new()
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address, :zip, :description)
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      flash[:notice] = 'Galpão cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Não existem galpões cadastrados.'
    end
    redirect_to root_path
  end
end
