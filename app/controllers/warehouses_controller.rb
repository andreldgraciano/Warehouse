class WarehousesController < ApplicationController
  before_action(:set_warehouse, only: [:show, :edit, :update])

  def show; end

  def new
    @warehouse = Warehouse.new()
  end

  def create
    @warehouse = Warehouse.new(warehouse_params())

    if @warehouse.save
      flash[:notice] = 'Galpão cadastrado com sucesso!'
      redirect_to(root_path)
    else
      flash.now[:notice] = 'Galpão não cadastrado.'
      return render('new')
    end
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params())
      flash[:notice] = 'Galpão atualizado com sucesso!'
      redirect_to(warehouse_path(@warehouse.id))
    else
      flash.now[:notice] = 'Galpão não pôde ser atualizado.'
      return render('edit')
    end
  end

  private

  def set_warehouse()
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :zip, :description)
  end
end
