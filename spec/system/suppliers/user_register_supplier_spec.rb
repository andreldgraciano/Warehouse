require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir da tela inicial' do
    # Arrange

    visit(root_path)
    within('nav') do
      click_on('Fornecedores')
    end
    click_on('Cadastrar Fornecedor')

    expect(page).to have_field('Razão Social')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Email')
  end

  it 'com sucesso' do
    # Arrange

    visit(root_path)
    within('nav') do
      click_on('Fornecedores')
    end
    click_on('Cadastrar Fornecedor')
    fill_in('Razão Social', with: 'Samsung Eletronics LTDA')
    fill_in('Nome Fantasia', with: 'Samsung')
    fill_in('CNPJ', with: '15654')
    fill_in('Endereço', with: 'Rua da Samsung, 321')
    fill_in('Cidade', with: 'São Paulo')
    fill_in('Estado', with: 'SP')
    fill_in('Email', with: 'sac@samsung.com.br')
    click_on('Enviar')

    expect(current_path).to eq(supplier_path(1))
    expect(page).to have_content('Fornecedor cadastrado com sucesso!')
    expect(page).to have_content('Samsung Eletronics LTDA')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('15654')
    expect(page).to have_content('Rua da Samsung, 321')
  end

  it 'com dados incompletos' do
    # Arrange

    visit(root_path)
    within('nav') do
      click_on('Fornecedores')
    end
    click_on('Cadastrar Fornecedor')
    fill_in('Razão Social', with: '')
    fill_in('Nome Fantasia', with: 'Samsung')
    fill_in('CNPJ', with: '15654')
    fill_in('Endereço', with: 'Rua da Samsung, 321')
    fill_in('Cidade', with: '')
    fill_in('Estado', with: '')
    fill_in('Email', with: 'sac@samsung.com.br')
    click_on('Enviar')

    expect(page).to have_content('Fornecedor não cadastrado.')
    expect(page).to have_field('Razão Social', with: '')
    expect(page).to have_field('Nome Fantasia', with: 'Samsung')
    expect(page).to have_field('CNPJ', with: '15654')
    expect(page).to have_field('Endereço', with: 'Rua da Samsung, 321')
    expect(page).to have_field('Cidade', with: '')
    expect(page).to have_field('Estado', with: '')
    expect(page).to have_field('Email', with: 'sac@samsung.com.br')
  end
end
