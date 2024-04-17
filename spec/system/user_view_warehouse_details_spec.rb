require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
  it 'e vê informações adicionais' do
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'SPO', city: 'São Paulo', area: 80_000,
    address: 'Avenida do aeroporto ,123', zip: 3812783812, description: 'Galpão do aeroporto de SP')

    visit('/')
    click_on 'Aeroporto SP'

    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('SPO')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('80000')
    expect(page).to have_content('Avenida do aeroporto ,123')
    expect(page).to have_content('3812783812')
    expect(page).to have_content('Galpão do aeroporto de SP')
  end

  it '' do

  end

  it '' do

  end
end
