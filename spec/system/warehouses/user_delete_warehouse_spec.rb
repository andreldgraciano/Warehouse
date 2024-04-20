require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    Warehouse.create!(
      name: 'Aeroporto SP',
      code: 'SPO',
      city: 'São Paulo',
      area: 80_000,
      address: 'Avenida do aeroporto ,123',
      zip: 3812783812,
      description: 'Galpão do aeroporto de SP'
    )

    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Remover')

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Galpão removido com sucesso')
    expect(page).not_to have_content('Aeroporto SP')
    expect(page).not_to have_content('SPO')
  end

  it 'e não apaga outros galpões' do
    Warehouse.create!(
      name: 'Sampa',
      code: 'SPY',
      city: 'São Paulo',
      area: 30_000,
      address: 'Rua do galpão SP, 1213',
      zip: 4235342523,
      description: 'Descricao galpao SP'
    )
    Warehouse.create!(
      name: 'Rio',
      code: 'SDU',
      city: 'Rio de Janeiro',
      area: 50_000,
      address: 'Rua do galpão RJ, 123',
      zip: 321312312,
      description: 'Descricao galpao RJ'
    )

    visit(root_path)
    click_on('Sampa')
    click_on('Remover')

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Galpão removido com sucesso')
    expect(page).not_to have_content('Sampa')
    expect(page).not_to have_content('SPY')
    expect(page).to have_content('Rio')
    expect(page).to have_content('SDU')
  end
end
