require 'rails_helper'

describe 'Usuario edita um pedido' do
  it 'e nao está autenticado' do
    user_1 = User.create!(
      email: 'andre@gmail.com',
      password: 'andre123@',
      name:'André Dias'
    )
    user_2 = User.create!(
      email: 'ataliba@gmail.com',
      password: 'ataliba123@',
      name:'Ataliba Couto'
    )
    warehouse = Warehouse.create!(
      name: 'Sampa',
      code: 'SPY',
      city: 'São Paulo',
      area: 30_000,
      address: 'Rua do galpão SP, 313',
      zip: 4235342523,
      description: 'Descricao galpao SP'
    )
    supplier = Supplier.create!(
      corporate_name: 'Samsung Eletronics LTDA',
      brand_name: 'Samsung',
      registration_number: 362173621,
      full_address: 'Rua da Samsung, 321',
      city: 'São Paulo',
      state: 'SP',
      email: 'sac@samsung.com.br'
    )
    order = Order.create!(
      user: user_1,
      warehouse: warehouse,
      supplier: supplier,
      estimated_delivery_date:
      1.day.from_now
    )
    
    patch(order_path(order.id), params: { order: { supplier_id: 3 }})

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'e nao é o dono' do
    user_1 = User.create!(
      email: 'andre@gmail.com',
      password: 'andre123@',
      name:'André Dias'
    )
    user_2 = User.create!(
      email: 'ataliba@gmail.com',
      password: 'ataliba123@',
      name:'Ataliba Couto'
    )
    warehouse = Warehouse.create!(
      name: 'Sampa',
      code: 'SPY',
      city: 'São Paulo',
      area: 30_000,
      address: 'Rua do galpão SP, 313',
      zip: 4235342523,
      description: 'Descricao galpao SP'
    )
    supplier = Supplier.create!(
      corporate_name: 'Samsung Eletronics LTDA',
      brand_name: 'Samsung',
      registration_number: 362173621,
      full_address: 'Rua da Samsung, 321',
      city: 'São Paulo',
      state: 'SP',
      email: 'sac@samsung.com.br'
    )
    order = Order.create!(
      user: user_1,
      warehouse: warehouse,
      supplier: supplier,
      estimated_delivery_date:
      1.day.from_now
    )

    login_as(user_2)
    patch(order_path(order.id), params: { order: { supplier_id: 3 }})

    expect(response).to redirect_to(root_path)
  end
end
