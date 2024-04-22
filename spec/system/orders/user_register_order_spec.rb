require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    #

    visit(root_path)
    click_on('Registrar Pedido')

    expect(current_path).to eq(new_user_session_path)
  end

  it 'com sucesso' do
    user = User.create!(email: 'andre@gmail.com', password: 'andre123@', name: 'André Dias')
    Warehouse.create!(
      name: 'Sampa',
      code: 'SPY',
      city: 'São Paulo',
      area: 30_000,
      address: 'Rua do galpão SP, 313',
      zip: 4235342523,
      description: 'Descricao galpao SP'
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
    Supplier.create!(
      corporate_name: 'Nokia LTDA',
      brand_name: 'Nokia',
      registration_number: 48464546,
      full_address: 'Rua da Nokia, 321',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'sac@nokia.com.br'
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

    login_as(user)
    visit(root_path)
    click_on('Registrar Pedido')
    select warehouse_1.full_description, from: 'Galpão Destino'
    select supplier_1.corporate_name, from: 'Fornecedor'
    fill_in('Data prevista de Entrega', with: '20/12/2022')
    click_on('Gravar')

    expect(current_path).to eq(order_path(1))
    expect(page).to have_content('Listar Pedidos')
    expect(page).to have_content('Pedido registrado com sucesso.')
    expect(page).to have_content('SDU - Rio')
    expect(page).to have_content('Samsung Eletronics LTDA')
    expect(page).to have_content('André Dias - andre@gmail.com')
    expect(page).to have_content('20/12/2022')
    expect(page).not_to have_content('Sampa')
    expect(page).not_to have_content('Nokia')
  end
end
