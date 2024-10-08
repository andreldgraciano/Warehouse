require 'rails_helper'

describe 'Usuário vê seus proprios pedidos' do
  it 'e deve estar autenticado' do
    #

    visit(root_path)

    expect(page).not_to have_link('Listar Pedidos')
  end

  it 'e deve possuir pedidos' do
    user = User.create!(
      email: 'andre@gmail.com',
      password: 'andre123@',
      name: 'André Dias'
    )

    login_as(user)
    visit(root_path)

    expect(page).not_to have_link('Listar Pedido')
    expect(page).to have_link('Registrar Pedido')
  end

  it 'e não vê pedidos de outros usuários' do
    user_1 = User.create!(
      email: 'andre@gmail.com',
      password: 'andre123@',
      name: 'André Dias'
    )
    user_2 = User.create!(
      email: 'ataliba@gmail.com',
      password: 'ataliba123@',
      name: 'Ataliba Couto'
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
    order_1 = Order.create!(
      user: user_1,
      warehouse: warehouse,
      supplier: supplier_1,
      estimated_delivery_date: 1.day.from_now,
      status: 'pending'
    )
    order_2 = Order.create!(
      user: user_2,
      warehouse: warehouse,
      supplier: supplier_1,
      estimated_delivery_date: 1.day.from_now,
      status: 'delivered'
    )
    order_3 = Order.create!(
      user: user_1,
      warehouse: warehouse,
      supplier: supplier_2,
      estimated_delivery_date: 1.day.from_now,
      status: 'canceled'
    )

    login_as(user_1)
    visit root_path
    click_on('Listar Pedidos')

    expect(page).to have_content("Pedido: #{order_1.code}")
    expect(page).to have_content("Pedido: #{order_3.code}")
    expect(page).not_to have_content("Pedido: #{order_2.code}")
    expect(page).to have_content('Situação do Pedido: Pendente')
    expect(page).to have_content('Situação do Pedido: Cancelado')
    expect(page).not_to have_content('Situação do Pedido: Entregue')
    expect(page).to have_content('Usuário Responsável: André Dias - andre@gmail.com')
    expect(page).to have_content('Galpão Destino: SPY - Sampa')
    expect(page).to have_content('Fornecedor: Samsung Eletronics LTDA')
    expect(page).to have_content('Fornecedor: Nokia LTDA')
  end

  it 'e visita um pedido' do
    user_1 = User.create!(
      email: 'andre@gmail.com',
      password: 'andre123@',
      name: 'André Dias'
    )
    user_2 = User.create!(
      email: 'ataliba@gmail.com',
      password: 'ataliba123@',
      name: 'Ataliba Couto'
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
      user: user_1,
      warehouse: warehouse,
      supplier: supplier,
      estimated_delivery_date: 1.day.from_now
    )

    login_as(user_2)
    visit(order_path(order.id))

    expect(current_path).not_to eq(order_path(1))
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Voce nao pode acessar pedido de outros usuários')
  end

  it 'e não visita pedidos de outros usuários' do
    user = User.create!(
      email: 'andre@gmail.com',
      password: 'andre123@',
      name: 'André Dias'
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
      estimated_delivery_date: 1.day.from_now
    )

    login_as(user)
    visit(root_path)
    click_on('Listar Pedidos')
    click_on(order.code)

    expect(page).to have_content("Pedido: #{order.code}")
    expect(page).to have_content('Usuário Responsável:')
    expect(page).to have_content('Galpão Destino: SPY - Sampa')
    expect(page).to have_content('Fornecedor: Samsung Eletronics LTDA')
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content("Data prevista de entrega: #{formatted_date}")
  end

  it 'e vê itens de um pedido' do
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
      sku: 'TC-32sam',
      supplier_id: supplier.id
    )
    product_2 = ProductModel.create!(
      name: 'Celular',
      weight: '23',
      width: '32',
      height: '23',
      depth: '12',
      sku: 'CELL-4k2h',
      supplier_id: supplier.id
    )
    product_3 = ProductModel.create!(
      name: 'Notebook',
      weight: '43',
      width: '23',
      height: '54',
      depth: '13',
      sku: 'Ibk2-br001',
      supplier_id: supplier.id
    )
    user = User.create!(
      email: 'andre@gmail.com',
      password: 'andre123@',
      name: 'André Dias'
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
    order = Order.create!(
      user: user,
      warehouse: warehouse,
      supplier: supplier,
      estimated_delivery_date: 1.day.from_now
    )
    OrderItem.create!(
      product_model: product_1,
      order: order,
      quantity: 2
    )
    OrderItem.create!(
      product_model: product_2,
      order: order,
      quantity: 4
    )

    login_as(user)
    visit(root_path)
    click_on('Listar Pedidos')
    click_on(order.code)

    expect(page).to have_content('Itens do Pedido')
    expect(page).to have_content('2 x Televisão')
    expect(page).to have_content('4 x Celular')
  end
end
