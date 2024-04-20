require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página de detalhes' do
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
    click_on('Editar')

    expect(page).to have_content('Editar fornecedor')
    expect(page).to have_field('Razão Social', with: 'Samsung Eletronics LTDA')
    expect(page).to have_field('Nome Fantasia', with: 'Samsung')
    expect(page).to have_field('CNPJ', with: '362173621')
    expect(page).to have_field('Endereço', with: 'Rua da Samsung, 321')
    expect(page).to have_field('Cidade', with: 'São Paulo')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('E-mail', with: 'sac@samsung.com.br')
  end

  it 'com sucesso' do
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
    click_on('Editar')
    fill_in('Razão Social', with: 'Samsung Eletronics LTDA')
    fill_in('Nome Fantasia', with: 'Samsung')
    fill_in('CNPJ', with: '362173621')
    fill_in('Endereço', with: 'Rua da Samsung, 321')
    fill_in('Cidade', with: 'São Paulo')
    fill_in('Estado', with: 'SP')
    fill_in('E-mail', with: 'sac@samsung.com.br')
    click_on('Enviar')

    expect(page).to have_content('Fornecedor atualizado com sucesso!')
    expect(page).to have_content('Samsung Eletronics LTDA')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('362173621')
    expect(page).to have_content('Rua da Samsung, 321')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).to have_content('sac@samsung.com.br')
  end

  it 'com campo vazio' do
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
    click_on('Editar')
    fill_in('Nome Fantasia', with: '')
    fill_in('Endereço', with: '')
    fill_in('E-mail', with: '')
    click_on('Enviar')

    expect(page).to have_content('Fornecedor não pôde ser atualizado.')
  end
end
