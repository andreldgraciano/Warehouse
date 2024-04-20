require 'rails_helper'

describe 'Usuário acessa o app e a partir da home' do
  it 'vê os fornecedores cadastrados' do
    Supplier.create!(
      corporate_name: 'Samsung Eletronics LTDA',
      brand_name: 'Samsung',
      registration_number: 362173621,
      full_address: 'Rua da Samsung, 321',
      city: 'São Paulo',
      state: 'SP',
      email: 'sac@samsung.com.br'
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

    visit(root_path)
    within('nav') do
      click_on('Fornecedores')
    end

    expect(page).not_to have_content('Não existem fornecedores cadastrados.')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).to have_content('Nokia')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('RJ')

  end

  it 'vê que não existem fornecedores cadastrados' do
    # Arrange

    visit(root_path)
    click_on('Fornecedores')

    expect(page).to have_content('Não existem fornecedores cadastrados.')
  end
end
