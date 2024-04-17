class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    #@warehouse = Warehouse.new

  end

  def create

    #if @warehouse.save
    #  flash[:notice] = 'Galpão cadastrado com sucesso!'
    #else
    #  flash.now[:notice] = 'Não existem galpões cadastrados.'
    #end
  end
end
