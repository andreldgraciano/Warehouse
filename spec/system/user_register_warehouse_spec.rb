require 'rails_helper'

describe 'Usuário cadastra um galpão' do
  it 'a partir da tela inicial' do
    # Arrange

    visit(root_path)
    click_on('Cadastrar Galpão')

    expect(page).to have_field('Nome')
    expect(page).to have_field('Código')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Área')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Descrição')
  end

  it 'com sucesso' do
    # Arrange

    visit(root_path)
    click_on('Cadastrar Galpão')
    fill_in('Nome', with: 'Aeroporto SP')
    fill_in('Código', with: 'SPO')
    fill_in('Cidade', with: 'São Paulo')
    fill_in('Área', with: '80000')
    fill_in('Endereço', with: 'Avenida do aeroporto ,123')
    fill_in('CEP', with: '3812783812')
    fill_in('Descrição', with: 'Galpão do aeroporto de SP')
    click_on('Enviar')

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Galpão cadastrado com sucesso!')
    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('SPO')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('80000')
  end

  it 'com dados incompletos' do
    # Arrange

    visit(root_path)
    click_on('Cadastrar Galpão')
    fill_in('Nome', with: '')
    fill_in('Código', with: 'SPO')
    fill_in('Cidade', with: 'São Paulo')
    fill_in('Área', with: '80000')
    fill_in('Endereço', with: '')
    fill_in('CEP', with: '')
    fill_in('Descrição', with: 'Galpão do aeroporto de SP')
    click_on('Enviar')

    expect(page).to have_content('Galpão não cadastrado.')
    expect(page).to have_content('')
    expect(page).to have_content('')
    expect(page).to have_content('')
    expect(page).to have_content('')
    expect(page).to have_content('')
    expect(page).to have_content('')
    expect(page).to have_content('')
  end
end
