require 'rails_helper'

describe 'Usuario busca por pedido' do
  it 'a partir do menu' do
    user = User.create!(
      name: 'Andre',
      email: 'andre@gmail.com',
      password: 'password'
    )

    login_as(user)
    visit root_path

    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'e deve estar autenticado' do
    #

    visit root_path

    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end

  it 'e não possui pedidos referente a busca' do
    user = User.create!(
      name: 'Andre',
      email: 'andre@gmail.com',
      password: 'password'
    )

    login_as(user)
    visit root_path
    fill_in('Buscar Pedido', with: 'Aj3azsh23')
    click_on('Buscar')

    expect(page).to have_content("Resultados da Busca por: Aj3azsh23")
    expect(page).to have_content('Nenhum pedido encontrado')
  end

  it 'e encontra um pedido' do
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
    visit root_path
    fill_in('Buscar Pedido', with: order.code)
    click_on('Buscar')

    expect(page).to have_content("Resultados da Busca por: #{order.code}")
    expect(page).to have_content('1 Pedido encontrado')
    expect(page).not_to have_content('Nenhum pedido encontrado')
    expect(page).to have_content("Pedido: #{order.code}")
    expect(page).to have_content('Usuário Responsável: André Dias - andre@gmail.com')
    expect(page).to have_content('Galpão Destino: SDU - Rio')
    expect(page).to have_content('Fornecedor: Samsung Eletronics LTDA')
  end

  it 'e encontra multiplos pedidos' do
    user = User.create!(
      email: 'andre@gmail.com',
      password: 'andre123@',
      name: 'André Dias'
    )
    warehouse_1 = Warehouse.create!(
      name: 'Rio',
      code: 'SDU',
      city: 'Rio de Janeiro',
      area: 50_000,
      address: 'Rua do galpão RJ, 123',
      zip: 321312312,
      description: 'Descricao galpao RJ'
    )
    warehouse_2 = Warehouse.create!(
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
    allow(SecureRandom).to receive(:alphanumeric).and_return('SDU53g0s')
    order_1 = Order.create!(
      user: user,
      warehouse: warehouse_1,
      supplier: supplier_1,
      estimated_delivery_date: 1.day.from_now
    )
    allow(SecureRandom).to receive(:alphanumeric).and_return('SDU43df1')
    order_2 = Order.create!(
      user: user,
      warehouse: warehouse_1,
      supplier: supplier_2,
      estimated_delivery_date: 1.day.from_now
    )
    allow(SecureRandom).to receive(:alphanumeric).and_return('SDUk19s7')
    order_3 = Order.create!(
      user: user,
      warehouse: warehouse_2,
      supplier: supplier_1,
      estimated_delivery_date: 1.day.from_now
    )

    login_as(user)
    visit root_path
    fill_in('Buscar Pedido', with: 'SDU')
    click_on('Buscar')

    expect(page).to have_content('Resultados da Busca por: SDU')
    expect(page).to have_content('3 Pedidos encontrados')
    expect(page).to have_content('Pedido: SDU53g0s')
    expect(page).to have_content('Pedido: SDU43df1')
    expect(page).to have_content('Pedido: SDUk19s7')
    expect(page).to have_content('Usuário Responsável: André Dias - andre@gmail.com')
    expect(page).to have_content('Galpão Destino: SDU - Rio')
    expect(page).to have_content('Galpão Destino: SPY - Sampa')
    expect(page).to have_content('Fornecedor: Samsung Eletronics LTDA')
    expect(page).to have_content('Fornecedor: Nokia LTDA')
  end
end
