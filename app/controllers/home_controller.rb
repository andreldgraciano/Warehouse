class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all
  end

  def show

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
