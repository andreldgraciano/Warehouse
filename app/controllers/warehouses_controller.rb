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
      flash.now[:notice] = 'Galpão não cadastrado.'
      return render('new')
    end

    redirect_to(root_path)
  end

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address, :zip, :description)
    @warehouse = Warehouse.find(params[:id])

    if @warehouse.update(warehouse_params)
      flash[:notice] = 'Galpão atualizado com sucesso!'
      redirect_to(warehouse_path(@warehouse.id))
    else
      flash.now[:notice] = 'Galpão não pôde ser atualizado.'
      return render('edit')
    end
  end
end
