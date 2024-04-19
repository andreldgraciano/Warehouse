require 'rails_helper'

describe 'Usuário acessa o app' do
  it 'e vê os galpões cadastrados' do
    Warehouse.create!(
      name: 'Rio',
      code: 'SDU',
      city: 'Rio de Janeiro',
      area: 50_000,
      address: 'Rua do galpão RJ, 123',
      zip: 321312312,
      description: 'Descricao galpao RJ')
    Warehouse.create!(
      name: 'Sampa',
      code: 'SPY',
      city: 'São Paulo',
      area: 30_000,
      address: 'Rua do galpão SP, 313',
      zip: 4235342523,
      description: 'Descricao galpao SP')

    visit(root_path)

    expect(page).not_to have_content('Não existem galpões cadastrados.')
    expect(page).to have_content('Rio')
    expect(page).to have_content('SDU')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('50000')
    expect(page).to have_content('Sampa')
    expect(page).to have_content('SPY')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('30000')
  end

  it 'e vê que não existem galpões cadastrados' do
    # Arrange

    visit(root_path)

    expect(page).to have_content('Não existem galpões cadastrados.')
  end
end
