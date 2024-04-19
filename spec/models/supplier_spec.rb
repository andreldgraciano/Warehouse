require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    it 'falso quando corporate_name é vazio' do
      supplier = Supplier.new(
        corporate_name: '',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br')

      result = supplier.valid?

      expect(result).to eq(false)
    end

    it 'falso quando brand_name é vazio' do
      supplier = Supplier.new(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: '',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br')

      result = supplier.valid?

      expect(result).to eq(false)
    end

    it 'falso quando registration_number é vazio' do
      supplier = Supplier.new(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: '',
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br')

      result = supplier.valid?

      expect(result).to eq(false)
    end

    it 'falso quando full_address é vazio' do
      supplier = Supplier.new(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: '',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br')

      result = supplier.valid?

      expect(result).to eq(false)
    end

    it 'falso quando city é vazio' do
      supplier = Supplier.new(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: '',
        state: 'SP',
        email: 'sac@samsung.com.br')

      result = supplier.valid?

      expect(result).to eq(false)
    end

    it 'falso quando state é vazio' do
      supplier = Supplier.new(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: '',
        email: 'sac@samsung.com.br')

      result = supplier.valid?

      expect(result).to eq(false)
    end

    it 'falso quando email é vazio' do
      supplier = Supplier.new(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: '')

      result = supplier.valid?

      expect(result).to eq(false)
    end
  end

  it 'falso quando brand_name não é único' do
    supplier_1 = Supplier.create!(
      corporate_name: 'Samsung Eletronics LTDA',
      brand_name: 'mesmo brand name',
      registration_number: 362173621,
      full_address: 'Rua da Samsung, 321',
      city: 'São Paulo',
      state: 'SP',
      email: 'sac@samsung.com.br')
    supplier_2 = Supplier.new(
      corporate_name: 'Nokia',
      brand_name: 'mesmo brand name',
      registration_number: 48464546,
      full_address: 'Rua da Nokia, 321',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'sac@nokia.com.br')

    result = supplier_2.valid?

    expect(result).to eq(false)
  end

  it 'falso quando registration_number não é único' do
    supplier_1 = Supplier.create!(
      corporate_name: 'Samsung Eletronics LTDA',
      brand_name: 'Samsung',
      registration_number: 123456789,
      full_address: 'Rua da Samsung, 321',
      city: 'São Paulo',
      state: 'SP',
      email: 'sac@samsung.com.br')
    supplier_2 = Supplier.new(
      corporate_name: 'Nokia',
      brand_name: 'Nokia LTDA',
      registration_number: 123456789,
      full_address: 'Rua da Nokia, 321',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'sac@nokia.com.br')

    result = supplier_2.valid?

    expect(result).to eq(false)
  end

  it 'falso quando email não é único' do
    supplier_1 = Supplier.create!(
      corporate_name: 'Samsung Eletronics LTDA',
      brand_name: 'Samsung',
      registration_number: 362173621,
      full_address: 'Rua da Samsung, 321',
      city: 'São Paulo',
      state: 'SP',
      email: 'sac@email.com.br')
    supplier_2 = Supplier.new(
      corporate_name: 'Nokia',
      brand_name: 'Nokia LTDA',
      registration_number: 48464546,
      full_address: 'Rua da Nokia, 321',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'sac@email.com.br')

    result = supplier_2.valid?

    expect(result).to eq(false)
  end
end
