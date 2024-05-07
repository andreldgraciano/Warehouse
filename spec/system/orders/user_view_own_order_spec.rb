require 'rails_helper'

describe 'Usuário vê seus proprios pedidos' do
  it 'e deve estar autenticado' do
    #

    visit(root_path)

    expect(page).not_to have_link('Listar Pedidos')
  end

  it 'e deve possuir pedidos' do
    user = User.create!(email: 'andre@gmail.com', password: 'andre123@', name: 'André Dias')

    login_as(user)
    visit(root_path)

    expect(page).not_to have_link('Listar Pedido')
    expect(page).to have_link('Registrar Pedido')
  end
end
