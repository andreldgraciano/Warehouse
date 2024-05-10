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
        estimated_delivery_date: 1.week.from_now,
      )

      result = order.valid?

      expect(result).to be(true)
    end

    it 'data estimada de entrega deve ser obrigatoria' do
      order = Order.new(
        estimated_delivery_date: '',
      )

      order.valid?
      result = order.errors.include? :estimated_delivery_date

      expect(result).to be true
    end

    it 'data estimada náo deve ser anterior a data do pedido' do
      order = Order.new(estimated_delivery_date: 1.day.ago)

      order.valid?
      result = order.errors.include? :estimated_delivery_date

      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser maior que hoje')
    end

    it 'data estimada não deve ser igual a hoje' do
      order = Order.new(estimated_delivery_date: Date.today)

      order.valid?
      result = order.errors.include? :estimated_delivery_date

      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser maior que hoje')
    end

    it 'data estimada deve ser igual ou maior que amanhã' do
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      order.valid?
      result = order.errors.include? :estimated_delivery_date

      expect(result).to be false
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
      order = Order.create!(
        warehouse: warehouse,
        supplier: supplier,
        user: user,
        estimated_delivery_date: 1.week.from_now
      )

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
        estimated_delivery_date: 1.week.from_now,
      )
      order_2 = Order.new(
        warehouse: warehouse,
        supplier: supplier,
        user: user,
        estimated_delivery_date: 1.week.from_now
      )

      order_2.save!

      expect(order_2.code).not_to eq(order_1.code)
    end

    it 'e o código não deve ser modificado' do
      user = User.create!(
        email: 'andre@gmail.com',
        password: 'andre123@',
        name: 'André Dias'
      )
      warehouse_1 = Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'SPO',
        city: 'São Paulo',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )
      warehouse_2 = Warehouse.new(
        name: 'Galpão Aeroporto RJ',
        code: 'WD1',
        city: 'Rio de Janeiro',
        area: 50_000,
        address: 'Rua da rodoviária ,433',
        zip: 2313213123,
        description: 'Galpão da rodoviária do rio'
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
      order = Order.create!(
        warehouse: warehouse_1,
        supplier: supplier,
        user: user,
        estimated_delivery_date: 1.day.from_now
      )
      original_code = order.code

      order.update!(estimated_delivery_date: 1.week.from_now)

      expect(original_code).to eq(order.code)
    end
  end
end
