require 'rails_helper'

describe 'Usuário acessa modelos de produtos' do
  it 'sem estar autenticado' do
    #

    visit(root_path)
    within('nav') do
      click_on('Modelos de Produtos')
    end

    expect(current_path).to eq(new_user_session_path)
  end

  it 'a partir do menu' do
    user = User.create!(name: 'Andre', email: 'andre@email.com', password: 'andre123')

    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Modelos de Produtos')
    end

    expect(current_path).to eq(product_models_path)
  end

  it 'e vê os modelos de produtos cadastrados' do
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
      name: 'SOUNDBOX',
      weight: 1000,
      width: 20,
      height: 25,
      depth: 23,
      sku: 'SBOX-XLSJ-KPM',
      supplier: supplier_2
    )
    ProductModel.create!(
      name: 'TV-32',
      weight: 500,
      width: 10,
      height: 15,
      depth: 12,
      sku: 'TV32-SAMS-XPT1U',
      supplier: supplier_1
    )

    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Modelos de Produtos')
    end

    expect(page).to have_content('SOUNDBOX')
    expect(page).to have_content('SBOX-XLSJ-KPM')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('TV-32')
    expect(page).to have_content('TV32-SAMS-XPT1U')
    expect(page).to have_content('Nokia')
  end

  it 'e vê que não existem modelos de produtos cadastrados' do
    user = User.create!(name: 'Andre', email: 'andre@email.com', password: 'andre123')

    login_as(user)
    visit(root_path)
    within('nav') do
      click_on('Modelos de Produtos')
    end

    expect(page).to have_content('Não existem modelos de produtos cadastrados.')
  end
end
