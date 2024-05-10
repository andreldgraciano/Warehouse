require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
      user = User.create!(
        email: 'andre@gmail.com',
        password: 'andre123@',
        name:'André Dias'
      )
      warehouse = Warehouse.create!(
        name: 'Sampa',
        code: 'SPY',
        city: 'São Paulo',
        area: 30_000,
        address: 'Rua do galpão SP, 313',
        zip: 4235342523,
        description: 'Descricao galpao SP'
      )
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      order = Order.create!(
        user: user,
        warehouse: warehouse,
        supplier: supplier,
        estimated_delivery_date: 1.day.from_now,
        status: :delivered
      )
      product = ProductModel.create!(
        name: 'Televisão',
        weight: '13',
        width: '32',
        height: '52',
        depth: '32',
        sku: 'TC-32sam',
        supplier: supplier
      )

      stock_product = StockProduct.create!(
        order: order,
        warehouse: warehouse,
        product_model: product
      )
      stock_product.update!(warehouse: warehouse)

      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do
      user = User.create!(
        email: 'andre@gmail.com',
        password: 'andre123@',
        name:'André Dias'
      )
      warehouse_1 = Warehouse.create!(
        name: 'Sampa',
        code: 'SPY',
        city: 'São Paulo',
        area: 30_000,
        address: 'Rua do galpão SP, 313',
        zip: 4235342523,
        description: 'Descricao galpao SP'
      )
      warehouse_2 = Warehouse.create!(
        name: 'Galpão Aeroporto RJ',
        code: 'WD1',
        city: 'Rio de Janeiro',
        area: 50_000,
        address: 'Rua da rodoviária ,433',
        zip: 2313213123,
        description: 'Galpão da rodoviária do rio'
      )
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      order = Order.create!(
        user: user,
        warehouse: warehouse_1,
        supplier: supplier,
        estimated_delivery_date: 1.day.from_now,
        status: :delivered
      )
      product = ProductModel.create!(
        name: 'Televisão',
        weight: '13',
        width: '32',
        height: '52',
        depth: '32',
        sku: 'TC-32sam',
        supplier: supplier
      )

      stock_product = StockProduct.create!(
        order: order,
        warehouse: warehouse_1,
        product_model: product
      )
      original_serial_number = stock_product.serial_number

      stock_product.update!(warehouse: warehouse_2)

      expect(original_serial_number).to eq(stock_product.serial_number)
    end
  end

  describe '#avaliable?' do
    it 'true se não tiver destino' do
      user = User.create!(
        email: 'andre@gmail.com',
        password: 'andre123@',
        name:'André Dias'
      )
      warehouse = Warehouse.create!(
        name: 'Sampa',
        code: 'SPY',
        city: 'São Paulo',
        area: 30_000,
        address: 'Rua do galpão SP, 313',
        zip: 4235342523,
        description: 'Descricao galpao SP'
      )
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      order = Order.create!(
        user: user,
        warehouse: warehouse,
        supplier: supplier,
        estimated_delivery_date: 1.day.from_now,
        status: :delivered
      )
      product = ProductModel.create!(
        name: 'Televisão',
        weight: '13',
        width: '32',
        height: '52',
        depth: '32',
        sku: 'TC-32sam',
        supplier: supplier
      )

      stock_product = StockProduct.create!(
        order: order,
        warehouse: warehouse,
        product_model: product
      )

      expect(stock_product.avaliable?).to eq(true)
    end

    it 'false se tiver destino' do
      user = User.create!(
        email: 'andre@gmail.com',
        password: 'andre123@',
        name:'André Dias'
      )
      warehouse = Warehouse.create!(
        name: 'Sampa',
        code: 'SPY',
        city: 'São Paulo',
        area: 30_000,
        address: 'Rua do galpão SP, 313',
        zip: 4235342523,
        description: 'Descricao galpao SP'
      )
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      order = Order.create!(
        user: user,
        warehouse: warehouse,
        supplier: supplier,
        estimated_delivery_date: 1.day.from_now,
        status: :delivered
      )
      product = ProductModel.create!(
        name: 'Televisão',
        weight: '13',
        width: '32',
        height: '52',
        depth: '32',
        sku: 'TC-32sam',
        supplier: supplier
      )

      stock_product = StockProduct.create!(
        order: order,
        warehouse: warehouse,
        product_model: product
      )
      stock_product.create_stock_product_destination!(recipient: 'André Dias', address: 'Rua das flores, 123, centro, Cidade - ES')

      expect(stock_product.avaliable?).to eq(false)
    end
  end
end
