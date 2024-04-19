require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de detalhes' do
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP',
      code: 'SPO',
      city: 'São Paulo',
      area: 80_000,
      address: 'Avenida do aeroporto ,123',
      zip: 3812783812,
      description: 'Galpão do aeroporto de SP')

    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Editar')

    expect(page).to have_content('Editar galpão')
    expect(page).to have_field('Nome', with: 'Aeroporto SP')
    expect(page).to have_field('Código', with: 'SPO')
    expect(page).to have_field('Cidade', with: 'São Paulo')
    expect(page).to have_field('Área', with: '80000')
    expect(page).to have_field('Endereço', with: 'Avenida do aeroporto ,123')
    expect(page).to have_field('CEP', with: '3812783812')
    expect(page).to have_field('Descrição', with: 'Galpão do aeroporto de SP')
  end

  it 'com sucesso' do
    Warehouse.create!(
      name: 'Aeroporto SP',
      code: 'SPO',
      city: 'São Paulo',
      area: 80_000,
      address: 'Avenida do aeroporto ,123',
      zip: 3812783812,
      description: 'Galpão do aeroporto de SP')

    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Editar')
    fill_in('Nome', with: 'Aeroporto Sampa')
    fill_in('Código', with: 'SPA')
    fill_in('Cidade', with: 'SãoPaulo')
    fill_in('Área', with: '50000')
    fill_in('Endereço', with: 'Avenida aeroporto ,432')
    fill_in('CEP', with: '31728937')
    fill_in('Descrição', with: 'Galpão aeroporto SP')
    click_on('Enviar')

    expect(page).to have_content('Galpão atualizado com sucesso!')
    expect(page).to have_content('Aeroporto Sampa')
    expect(page).to have_content('SPA')
    expect(page).to have_content('SãoPaulo')
    expect(page).to have_content('50000')
    expect(page).to have_content('Avenida aeroporto ,432')
    expect(page).to have_content('31728937')
    expect(page).to have_content('Galpão aeroporto SP')
  end

  it 'com campo vazio' do
    Warehouse.create!(
      name: 'Aeroporto SP',
      code: 'SPO',
      city: 'São Paulo',
      area: 80_000,
      address: 'Avenida do aeroporto ,123',
      zip: 3812783812,
      description: 'Galpão do aeroporto de SP')

    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Editar')
    fill_in('Cidade', with: '')
    fill_in('Endereço', with: '')
    fill_in('Descrição', with: '')
    click_on('Enviar')

    expect(page).to have_content('Galpão não pôde ser atualizado.')
  end
end
