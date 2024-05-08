require 'rails_helper'

describe 'Usuario edita um pedido' do
  it 'e deve estar autenticado' do
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
      estimated_delivery_date:
      1.day.from_now
    )

    visit(edit_order_path(order.id))

    expect(current_path).to eq(new_user_session_path)
  end

  it 'com sucesso' do
    user = User.create!(
      email: 'andre@gmail.com',
      password: 'andre123@',
      name: 'André Dias'
    )
    warehouse = Warehouse.create!(
      name: 'Rio',
      code: 'SDU',
      city: 'Rio de Janeiro',
      area: 50_000,
      address: 'Rua do galpão RJ, 123',
      zip: 321312312,
      description: 'Descricao galpao RJ'
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
      supplier: supplier_2,
      estimated_delivery_date:
      1.day.from_now
    )

    code = order.code
    login_as(user)
    visit(root_path)
    click_on('Listar Pedidos')
    click_on(code)
    click_on('Editar')
    formatted_date = I18n.localize(2.days.from_now.to_date)
    fill_in('Data prevista de entrega', with: formatted_date)
    select('Samsung Eletronics LTDA', from: 'Fornecedor')
    click_on('Gravar')

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Pedido atualizado com sucesso!')
    expect(page).to have_content(code)
    expect(page).to have_content('SDU - Rio')
    expect(page).to have_content('Samsung Eletronics LTDA')
    expect(page).to have_content("Data prevista de entrega: #{formatted_date}")
  end

  it 'caso seja o responsavel' do
    user_1 = User.create!(
      email: 'andre@gmail.com',
      password: 'andre123@',
      name:'André Dias'
    )
    user_2 = User.create!(
      email: 'ataliba@gmail.com',
      password: 'ataliba123@',
      name:'Ataliba Couto'
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
      estimated_delivery_date:
      1.day.from_now
    )

    login_as(user_2)
    visit(edit_order_path(order.id))

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Voce nao pode acessar pedido de outros usuários')
  end
end
