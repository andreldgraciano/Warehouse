require 'rails_helper'

describe 'Usuario se autentica' do
  it 'com sucesso' do
    User.create!(email: 'andre@gmail.com', password: 'andre123@', name: 'André Dias')

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
      expect(page).to have_button('Sair')
      expect(page).to have_content('André Dias')
    end
  end

  it 'e faz logout' do
    User.create!(email: 'andre@gmail.com', password: 'andre123@', name: 'André Dias')

    visit(root_path)
    click_on('Entrar')
    within('form') do
      fill_in('E-mail', with: 'andre@gmail.com')
      fill_in('Senha', with: 'andre123@')
      click_on('Entrar')
    end
    click_on('Sair')

    expect(page).to have_content('Logout efetuado com sucesso.')
    within('nav') do
      expect(page).to have_link('Entrar')
      expect(page).not_to have_button('Sair')
      expect(page).not_to have_content('andre@gmail.com')
    end
  end
end
