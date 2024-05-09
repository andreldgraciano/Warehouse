require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
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

    login_as(user)
    visit(root_path)
    click_on('Listar Pedidos')
    click_on(order.code)
    click_on('Entregue')

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Situação do Pedido: Entregue')
    expect(page).not_to have_button('Entregue')
    expect(page).not_to have_button('Cancelar')
  end

  it 'e pedido foi cancelado' do
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

    login_as(user)
    visit(root_path)
    click_on('Listar Pedidos')
    click_on(order.code)
    click_on('Cancelar')

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Situação do Pedido: Cancelado')
    expect(page).not_to have_button('Entregue')
    expect(page).not_to have_button('Cancelar')
  end
end