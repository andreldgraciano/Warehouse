require 'rails_helper'

describe 'Usuário vê detalhes de um modelo de produto' do
  it 'e vê informações adicionais' do
    user = User.create!(name: 'Andre', email: 'andre@email.com', password: 'andre123')
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
      registration_number: 1132324323,
      full_address: 'Avenida da Nokia, 51',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'sac@nokia.com.br'
    )
    ProductModel.create!(
      name: 'TV-32',
      weight: 1000,
      width: 20,
      height: 25,
      depth: 23,
      sku: 'TV32-SAMS-XPT1U',
      supplier: supplier_2
    )

    login_as(user)
    visit(root_path)
    click_on('Modelos de Produtos')
    click_on('TV-32')

    expect(page).to have_content('TV-32')
    expect(page).to have_content('TV32-SAMS-XPT1U')
    expect(page).to have_content('Nokia')
  end

  it 'e volta para a tela inicial' do
    user = User.create!(name: 'Andre', email: 'andre@email.com', password: 'andre123')
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
      registration_number: 1132324323,
      full_address: 'Avenida da Nokia, 51',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'sac@nokia.com.br'
    )
    ProductModel.create!(
      name: 'TV-32',
      weight: 1000,
      width: 20,
      height: 25,
      depth: 23,
      sku: 'TV32-SAMS-XPT1U',
      supplier: supplier_1
    )

    login_as(user)
    visit(root_path)
    click_on('Modelos de Produtos')
    click_on('TV-32')
    click_on('Galpões')

    expect(current_path).to eq(root_path)
  end
end
