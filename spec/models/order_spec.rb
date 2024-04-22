require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'SPO',
        city: 'São Paulo',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )
      supplier = Supplier.create!(
        corporate_name: 'Nokia LTDA',
        brand_name: 'Nokia',
        registration_number: 48464546,
        full_address: 'Rua da Nokia, 321',
        city: 'Rio de Janeiro',
        state: 'RJ',
        email: 'sac@nokia.com.br'
      )
      user = User.create!(
        email: 'andre@gmail.com',
        password: 'andre123@',
        name: 'André Dias'
      )
      order = Order.new(
        warehouse: warehouse,
        supplier: supplier,
        user: user,
        estimated_delivery_date: '2022-10-01',
        # code:
      )

      result = order.valid?

      expect(result).to be(true)
    end
  end

  describe 'Gera um código aleatório' do
    it 'ao criar um novo pedido' do
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'SPO',
        city: 'São Paulo',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )
      supplier = Supplier.create!(
        corporate_name: 'Nokia LTDA',
        brand_name: 'Nokia',
        registration_number: 48464546,
        full_address: 'Rua da Nokia, 321',
        city: 'Rio de Janeiro',
        state: 'RJ',
        email: 'sac@nokia.com.br'
      )
      user = User.create!(
        email: 'andre@gmail.com',
        password: 'andre123@',
        name: 'André Dias'
      )
      order = Order.new(
        warehouse: warehouse,
        supplier: supplier,
        user: user,
        estimated_delivery_date: '2022-10-01',
        # code:
      )

      order.save!
      result = order.code

      expect(result).not_to be_empty()
      expect(result.length).to eq(10)
    end

    it 'e o código é único' do
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'SPO',
        city: 'São Paulo',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )
      supplier = Supplier.create!(
        corporate_name: 'Nokia LTDA',
        brand_name: 'Nokia',
        registration_number: 48464546,
        full_address: 'Rua da Nokia, 321',
        city: 'Rio de Janeiro',
        state: 'RJ',
        email: 'sac@nokia.com.br'
      )
      user = User.create!(
        email: 'andre@gmail.com',
        password: 'andre123@',
        name: 'André Dias'
      )
      order_1 = Order.create!(
        warehouse: warehouse,
        supplier: supplier,
        user: user,
        estimated_delivery_date: '2022-10-01',
      )
      order_2 = Order.new(
        warehouse: warehouse,
        supplier: supplier,
        user: user,
        estimated_delivery_date: '2022-11-15',
      )

      order_2.save!

      expect(order_2.code).not_to eq(order_1.code)
    end
  end
end
