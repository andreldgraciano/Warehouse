require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
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

    visit(root_path)
    click_on('Fornecedores')
    click_on('Samsung')

    expect(page).to have_content('Samsung Eletronics LTDA')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('362173621')
    expect(page).to have_content('Rua da Samsung, 321')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).to have_content('sac@samsung.com.br')
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

    visit(root_path)
    click_on('Fornecedores')
    click_on('Samsung')
    click_on('Galpões')

    expect(current_path).to eq(root_path)
  end
end
