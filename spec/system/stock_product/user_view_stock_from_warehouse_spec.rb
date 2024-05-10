require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
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
    product_1 = ProductModel.create!(
      name: 'Televisão',
      weight: '13',
      width: '32',
      height: '52',
      depth: '32',
      sku: 'TV-32sam',
      supplier: supplier
    )
    product_2 = ProductModel.create!(
      name: 'Celular',
      weight: '23',
      width: '32',
      height: '23',
      depth: '12',
      sku: 'CELL-4k2h',
      supplier: supplier
    )
    product_3 = ProductModel.create!(
      name: 'Notebook',
      weight: '32',
      width: '12',
      height: '14',
      depth: '8',
      sku: 'NOTE-832J',
      supplier: supplier
    )
    order = Order.create!(
      user: user,
      warehouse: warehouse,
      supplier: supplier,
      estimated_delivery_date: 1.day.from_now,
      status: :pending
    )
    3.times { StockProduct.create(order: order, warehouse: warehouse, product_model: product_1) }
    2.times { StockProduct.create(order: order, warehouse: warehouse, product_model: product_2) }

    login_as(user)
    visit(root_path)
    click_on('Sampa')

    within('section#stock_products') do
      expect(page).to have_content('Itens em Estoque')
      expect(page).to have_content('3 x TV-32sam')
      expect(page).to have_content('2 x CELL-4k2h')
      expect(page).not_to have_content('NOTE-832J')
    end
  end

  it 'e da baixa em um item' do
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
      status: :pending
    )
    product = ProductModel.create!(
      name: 'Televisão',
      weight: '13',
      width: '32',
      height: '52',
      depth: '32',
      sku: 'TV-32sam',
      supplier: supplier
    )
    2.times { StockProduct.create(order: order, warehouse: warehouse, product_model: product) }

    login_as(user)
    visit(root_path)
    click_on('Sampa')
    select('TV-32sam', from: 'Item para Saída')
    fill_in('Destinatário', with: 'Maria Ferreira')
    fill_in('Endereço Destino', with: 'Rua das palmeiras, 100 - Campinas - São Paulo')
    click_on('Confirmar Retirada')

    expect(current_path).to eq(warehouse_path(warehouse.id))
    expect(page).to have_content('Item retirado com sucesso')
    expect(page).to have_content('1 x TV-32sam')
  end
end
