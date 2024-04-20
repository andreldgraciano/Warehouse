require 'rails_helper'

describe 'Usuário edita um modelo de produto' do
  it 'a partir da página de detalhes' do
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

    visit(root_path)
    click_on('Modelos de Produtos')
    click_on('TV-32')
    click_on('Editar')

    expect(page).to have_content('Editar modelo de produto')
    expect(page).to have_field('Nome', with: 'TV-32')
    expect(page).to have_field('Peso', with: '1000')
    expect(page).to have_field('Largura', with: '20')
    expect(page).to have_field('Altura', with: '25')
    expect(page).to have_field('Profundidade', with: '23')
    expect(page).to have_field('SKU', with: 'TV32-SAMS-XPT1U')
    expect(page).to have_select('Fornecedor', selected: 'Nokia')
  end

  it 'com sucesso' do
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

    visit(root_path)
    click_on('Modelos de Produtos')
    click_on('TV-32')
    click_on('Editar')
    fill_in('Nome', with: 'TV 40 polegadas')
    fill_in('Peso', with: '10000')
    fill_in('Largura', with: '60')
    fill_in('Altura', with: '30')
    fill_in('Profundidade', with: '35')
    fill_in('SKU', with: 'TV40-SAMS-XPT1U')
    select('Nokia', from: 'Fornecedor')
    click_on('Enviar')

    expect(page).to have_content('Modelo de Produto atualizado com sucesso!')
    expect(page).to have_content('TV 40 polegadas')
    expect(page).to have_content('Nokia')
    expect(page).to have_content('60 x 30 x 35')
    expect(page).to have_content('TV40-SAMS-XPT1U')
    expect(page).to have_content('10000')
  end

  it 'com campo vazio' do
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

    visit(root_path)
    click_on('Modelos de Produtos')
    click_on('TV-32')
    click_on('Editar')
    fill_in('Nome', with: '')
    fill_in('SKU', with: '')
    fill_in('Altura', with: '')
    click_on('Enviar')

    expect(page).to have_content('Modelo de Produto não pôde ser atualizado.')
  end
end
