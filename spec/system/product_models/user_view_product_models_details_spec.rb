require 'rails_helper'

describe 'Usuário vê detalhes de um modelo de produto' do
  it 'e vê informações adicionais' do
    Supplier.create!(
      corporate_name: 'Samsung Eletronics LTDA',
      brand_name: 'Samsung',
      registration_number: 362173621,
      full_address: 'Rua da Samsung, 321',
      city: 'São Paulo',
      state: 'SP',
      email: 'sac@samsung.com.br'
    )
    ProductModel.create!(
      name: 'TV-32',
      weight: 1000,
      width: 20,
      height: 25,
      depth: 23,
      sku: 'TV32-SAMS-XPT1U',
      supplier_id: 1
    )

    visit(root_path)
    click_on('Modelos de Produtos')
    click_on('TV-32')

    expect(page).to have_content('TV-32')
    expect(page).to have_content('TV32-SAMS-XPT1U')
    expect(page).to have_content('Samsung')
  end

  it 'e volta para a tela inicial' do
    Supplier.create!(
      corporate_name: 'Samsung Eletronics LTDA',
      brand_name: 'Samsung',
      registration_number: 362173621,
      full_address: 'Rua da Samsung, 321',
      city: 'São Paulo',
      state: 'SP',
      email: 'sac@samsung.com.br'
    )
    ProductModel.create!(
      name: 'TV-32',
      weight: 1000,
      width: 20,
      height: 25,
      depth: 23,
      sku: 'TV32-SAMS-XPT1U',
      supplier_id: 1
    )

    visit(root_path)
    click_on('Modelos de Produtos')
    click_on('TV-32')
    click_on('Galpões')

    expect(current_path).to eq(root_path)
  end
end
