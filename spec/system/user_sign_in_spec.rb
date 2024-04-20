require 'rails_helper'

describe 'Usuario se autentica' do
  it 'com sucesso' do
    User.create!(email: 'andre@gmail.com', password: 'andre123@')

    visit(root_path)
    click_on('Entrar')
    within('form') do
      fill_in('E-mail', with: 'andre@gmail.com')
      fill_in('Senha', with: 'andre123@')
      click_on('Entrar')
    end

    expect(page).to have_content('Login efetuado com sucesso.')
    within('nav') do
      expect(page).not_to have_link('Entrar')
      expect(page).to have_link('Sair')
      expect(page).to have_content('andre@gmail.com')
    end
  end
end
