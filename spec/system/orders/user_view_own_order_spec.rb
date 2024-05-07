require 'rails_helper'

describe 'Usuário vê seus proprios pedidos' do
  it 'e deve estar autenticado' do
    #

    visit(root_path)

    expect(page).not_to have_link('Listar Pedidos')
  end

  it 'e deve possuir pedidos' do
    user = User.create!(email: 'andre@gmail.com', password: 'andre123@', name: 'André Dias')

    login_as(user)
    visit(root_path)

    expect(page).not_to have_link('Listar Pedido')
    expect(page).to have_link('Registrar Pedido')
  end

  it 'e não vê pedidos de outros usuários' do
    user_1 = User.create!(email: 'andre@gmail.com', password: 'andre123@', name: 'André Dias')
    user_2 = User.create!(email: 'ataliba@gmail.com', password: 'ataliba123@', name: 'Ataliba Couto')
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
    order_1 = Order.create!(user: user_1, warehouse: warehouse, supplier: supplier_1, estimated_delivery_date: 1.day.from_now)
    order_2 = Order.create!(user: user_2, warehouse: warehouse, supplier: supplier_1, estimated_delivery_date: 1.day.from_now)
    order_3 = Order.create!(user: user_1, warehouse: warehouse, supplier: supplier_2, estimated_delivery_date: 1.day.from_now)

    login_as(user_1)
    visit root_path
    click_on('Listar Pedidos')

    expect(page).to have_content("Pedido: #{order_1.code}")
    expect(page).to have_content("Pedido: #{order_3.code}")
    expect(page).to have_content('Usuário Responsável: André Dias - andre@gmail.com')
    expect(page).to have_content('Galpão Destino: SPY - Sampa')
    expect(page).to have_content('Fornecedor: Samsung Eletronics LTDA')
    expect(page).to have_content('Fornecedor: Nokia LTDA')
    expect(page).not_to have_content("Pedido: #{order_2.code}")
  end
end
