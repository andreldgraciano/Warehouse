require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #

    visit(root_path)
    click_on('Entrar')
    click_on('Criar uma conta')
    fill_in('Nome', with: 'André Dias')
    fill_in('E-mail', with: 'andre@gmail.com')
    fill_in('Senha', with: 'andre123')
    fill_in('Confirme sua senha', with: 'andre123')
    click_on('Criar conta')

    expect(page).to have_content('Boas vindas! Você realizou seu registro com sucesso.')
    expect(page).to have_content('André Dias')
    expect(page).to have_button('Sair')
  end
end
