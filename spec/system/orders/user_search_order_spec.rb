require 'rails_helper'

describe 'Usuario busca por um pedido' do
  it 'a partir do menu' do
    user = User.create!(name: 'Andre', email: 'andre@gmail.com', password: 'password')

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

  it 'e encontra um pedido' do
    user = User.create!(email: 'andre@gmail.com', password: 'andre123@', name: 'André Dias')
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
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in('Buscar Pedido', with: order.code)
    click_on('Buscar')

    expect(page).to have_content("Resultados da Busca por: #{order.code}")
    expect(page).to have_content('1 Pedido encontrado')
    expect(page).to have_content("Código: #{order.code}")
    expect(page).to have_content('Galpão Destino: SDU - Rio')
    expect(page).to have_content('Fornecedor: Samsung Eletronics LTDA')
  end
end
