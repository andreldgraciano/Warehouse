require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
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
    product_1 = ProductModel.create!(
      name: 'Televisão',
      weight: '13',
      width: '32',
      height: '52',
      depth: '32',
      sku: 'TC-32sam',
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

    login_as(user)
    visit(root_path)
    click_on('Listar Pedidos')
    click_on(order.code)
    click_on('Adicionar Item')
    select('Televisão', from: 'Produto')
    fill_in('Quantidade', with: '8')
    click_on('Gravar')

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Item adicionado com sucesso')
    expect(page).to have_content('8 x Televisão')
  end

  it 'e nao vê produtos de outro fornecedor' do
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
    supplier_1 = Supplier.create!(
      corporate_name: 'Samsung Eletronics LTDA',
      brand_name: 'Samsung',
      registration_number: 362173621,
      full_address: 'Rua da Samsung, 321',
      city: 'São Paulo',
      state: 'SP',
      email: 'sac@samsung.com.br'
    )
    supplier_2 = Supplier.create!(
      corporate_name: 'Nokia LTDA',
      brand_name: 'Nokia',
      registration_number: 48464546,
      full_address: 'Rua da Nokia, 321',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'sac@nokia.com.br'
    )
    order = Order.create!(
      user: user,
      warehouse: warehouse,
      supplier: supplier_1,
      estimated_delivery_date: 1.day.from_now,
      status: :pending
    )
    product_1 = ProductModel.create!(
      name: 'Televisão',
      weight: '13',
      width: '32',
      height: '52',
      depth: '32',
      sku: 'TC-32sam',
      supplier: supplier_1
    )
    product_2 = ProductModel.create!(
      name: 'Celular',
      weight: '23',
      width: '32',
      height: '23',
      depth: '12',
      sku: 'CELL-4k2h',
      supplier: supplier_2
    )

    login_as(user)
    visit(root_path)
    click_on('Listar Pedidos')
    click_on(order.code)
    click_on('Adicionar Item')

    expect(page).to have_content('Televisão')
    expect(page).not_to have_content('Celular')
  end
end
