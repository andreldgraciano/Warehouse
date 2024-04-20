class SuppliersController < ApplicationController
  before_action(:set_supplier, only: [:show, :edit, :update])

  def index
    @suppliers = Supplier.all
  end

  def show; end

  def new
    @supplier = Supplier.new()
  end

  def create
    @supplier = Supplier.new(supplier_params())

    if @supplier.save
      flash[:notice] = 'Fornecedor cadastrado com sucesso!'
      redirect_to(@supplier)
    else
      flash.now[:notice] = 'Fornecedor não cadastrado.'
      return render('new')
    end
  end

  def edit; end

  def update
    if @supplier.update(supplier_params())
      flash[:notice] = 'Fornecedor atualizado com sucesso!'
      redirect_to(@supplier)
    else
      flash.now[:notice] = 'Fornecedor não pôde ser atualizado.'
      return render('edit')
    end
  end

  private

  def set_supplier()
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email)
  end
end
