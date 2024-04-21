require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
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

    login_as(user)
    visit(root_path)
    click_on('Modelos de Produtos')
    click_on('Cadastrar Modelo de Produto')
    fill_in('Nome', with: 'TV 40 polegadas')
    fill_in('Peso', with: '10000')
    fill_in('Largura', with: '60')
    fill_in('Altura', with: '30')
    fill_in('Profundidade', with: '25')
    fill_in('SKU', with: 'TV40-NOK-CJH')
    select('Nokia', from: 'Fornecedor')
    click_on('Enviar')

    expect(page).to have_content('Modelo de Produto cadastrado com sucesso!')
    expect(page).to have_content('TV 40 polegadas')
    expect(page).to have_content('Nokia')
    expect(page).to have_content('60 x 30 x 25')
    expect(page).to have_content('TV40-NOK-CJH')
    expect(page).to have_content('10000')
  end

  it 'com dados imcompletos' do
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

    login_as(user)
    visit(root_path)
    click_on('Modelos de Produtos')
    click_on('Cadastrar Modelo de Produto')
    fill_in('Nome', with: 'TV 40 polegadas')
    fill_in('Peso', with: '')
    fill_in('Largura', with: '60')
    fill_in('Altura', with: '')
    fill_in('Profundidade', with: '25')
    fill_in('SKU', with: '')
    select('Nokia', from: 'Fornecedor')
    click_on('Enviar')

    expect(page).to have_content('Modelo de Produto não cadastrado.')
    expect(page).to have_field('Nome', with: 'TV 40 polegadas')
    expect(page).to have_field('Peso', with: '')
    expect(page).to have_field('Largura', with: '60')
    expect(page).to have_field('Altura', with: '')
    expect(page).to have_field('Profundidade', with: '25')
    expect(page).to have_field('SKU', with: '')
    expect(page).to have_select('Fornecedor', selected: 'Nokia')
  end
end
