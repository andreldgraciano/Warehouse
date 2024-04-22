require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    it 'falso quando name é vazio' do
      warehouse = Warehouse.new(name: '',
        code: 'SPO',
        city: 'São Paulo',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )

      result = warehouse.valid?

      expect(result).to eq(false)
    end

    it 'falso quando code é vazio' do
      warehouse = Warehouse.new(name: 'Galpão Aeroporto SP',
        code: '',
        city: 'São Paulo',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )

      result = warehouse.valid?

      expect(result).to eq(false)
    end

    it 'falso quando city é vazio' do
      warehouse = Warehouse.new(name: 'Galpão Aeroporto SP',
        code: 'SPO',
        city: '',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )

      result = warehouse.valid?

      expect(result).to eq(false)
    end

    it 'falso quando area é vazio' do
      warehouse = Warehouse.new(
        name: 'Galpão Aeroporto SP',
        code: 'SPO',
        city: 'São Paulo',
        area: '',
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )

      result = warehouse.valid?

      expect(result).to eq(false)
    end

    it 'falso quando address é vazio' do
      warehouse = Warehouse.new(
        name: 'Galpão Aeroporto SP',
        code: 'SPO',
        city: 'São Paulo',
        area: 80_000,
        address: '',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )

      result = warehouse.valid?

      expect(result).to eq(false)
    end

    it 'falso quando zip é vazio' do
      warehouse = Warehouse.new(
        name: 'Galpão Aeroporto SP',
        code: 'SPO',
        city: 'São Paulo',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: '',
        description: 'Galpão do aeroporto de SP'
      )

      result = warehouse.valid?

      expect(result).to eq(false)
    end

    it 'falso quando description é vazio' do
      warehouse = Warehouse.new(
        name: 'Galpão Aeroporto SP',
        code: 'SPO',
        city: 'São Paulo',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: ''
      )

      result = warehouse.valid?

      expect(result).to eq(false)
    end
  end

  describe '#uniqueness?' do
    it 'falso quando code não é único' do
      warehouse_1 = Warehouse.create!(
        name: 'Galpão Aeroporto SP',
        code: 'WD1',
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

      result = warehouse_2.valid?

      expect(result).to eq(false)
    end
  end

  describe '#full_description' do
    it 'exibe o nome fantasia e razão social' do
      w = Warehouse.new(name: 'Galpão Cuiabá', code: 'CBA')

      result = w.full_description()

      expect(result).to eq('CBA - Galpão Cuiabá')
    end
  end
end
