require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da app' do
    visit('/')

    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê os galpões cadastrados' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: '50_000')
    Warehouse.create!(name: 'Sampa', code: 'SPY', city: 'São Paulo', area: '30_000')

    visit('/')

    expect(page).to have_content('Galpão cadastrado com sucesso!')
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

  it 'e não existem galpões cadastrados' do
    visit('/')

    expect(page).to have_content('Não existem galpões cadastrados.')
    expect(page).not_to have_content('Galpão cadastrado com sucesso!')
  end
end
