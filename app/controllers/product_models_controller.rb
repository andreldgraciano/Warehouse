class ProductModelsController < ApplicationController
  before_action(:set_product_model, only: [:show, :edit, :update])

  def index
    @product_models = ProductModel.all
  end

  def show; end

  def new
    @product_model = ProductModel.new()
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_model_params())

    if @product_model.save
      flash[:notice] = 'Modelo de Produto cadastrado com sucesso!'
      redirect_to(@product_model)
    else
      @suppliers = Supplier.all
      flash.now[:notice] = 'Modelo de Produto não cadastrado.'
      return render('new')
    end
  end

  def edit
    @suppliers = Supplier.all
  end

  def update
    if @product_model.update(product_model_params())
      flash[:notice] = 'Modelo de Produto atualizado com sucesso!'
      redirect_to(@product_model)
    else
      @suppliers = Supplier.all
      flash.now[:notice] = 'Modelo de Produto não pôde ser atualizado.'
      return render('edit')
    end
  end

  private

  def set_product_model()
    @product_model = ProductModel.find(params[:id])
  end

  def product_model_params
    params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
  end
end
