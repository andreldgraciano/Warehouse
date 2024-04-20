require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'falso quando name é vazio' do
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      product_model = ProductModel.new(
        name: '',
        weight: 1000,
        width: 20,
        height: 25,
        depth: 23,
        sku: 'TV32-SAMS-XPT1U',
        supplier: supplier
      )

      result = product_model.valid?

      expect(result).to eq(false)
    end

    it 'falso quando weight é vazio' do
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      product_model = ProductModel.new(
        name: 'TV-32',
        weight: '',
        width: 20,
        height: 25,
        depth: 23,
        sku: 'TV32-SAMS-XPT1U',
        supplier: supplier
      )

      result = product_model.valid?

      expect(result).to eq(false)
    end

    it 'falso quando width é vazio' do
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      product_model = ProductModel.new(
        name: 'TV-32',
        weight: 1000,
        width: '',
        height: 25,
        depth: 23,
        sku: 'TV32-SAMS-XPT1U',
        supplier: supplier
      )

      result = product_model.valid?

      expect(result).to eq(false)
    end

    it 'falso quando height é vazio' do
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      product_model = ProductModel.new(
        name: 'TV-32',
        weight: 1000,
        width: 20,
        height: '',
        depth: 23,
        sku: 'TV32-SAMS-XPT1U',
        supplier: supplier
      )

      result = product_model.valid?

      expect(result).to eq(false)
    end

    it 'falso quando depth é vazio' do
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      product_model = ProductModel.new(
        name: 'TV-32',
        weight: 1000,
        width: 20,
        height: 25,
        depth: '',
        sku: 'TV32-SAMS-XPT1U',
        supplier: supplier
      )

      result = product_model.valid?

      expect(result).to eq(false)
    end

    it 'falso quando sku é vazio' do
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      product_model = ProductModel.new(
        name: 'TV-32',
        weight: 1000,
        width: 20,
        height: 25,
        depth: 23,
        sku: '',
        supplier: supplier
      )

      result = product_model.valid?

      expect(result).to eq(false)
    end

    it 'falso quando name não é único' do
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      product_model_1 = ProductModel.create!(
        name: 'TV-32',
        weight: 1000,
        width: 20,
        height: 25,
        depth: 23,
        sku: 'TV32-SAMS-XPT1U',
        supplier: supplier
      )
      product_model_2 = ProductModel.new(
        name: 'TV-32',
        weight: 2000,
        width: 32,
        height: 15,
        depth: 16,
        sku: 'TV32-XML',
        supplier: supplier
      )

      result = product_model_2.valid?

      expect(result).to eq(false)
    end

    it 'falso quando sku não é único' do
      supplier = Supplier.create!(
        corporate_name: 'Samsung Eletronics LTDA',
        brand_name: 'Samsung',
        registration_number: 362173621,
        full_address: 'Rua da Samsung, 321',
        city: 'São Paulo',
        state: 'SP',
        email: 'sac@samsung.com.br'
      )
      product_model_1 = ProductModel.create!(
        name: 'TV-32',
        weight: 1000,
        width: 20,
        height: 25,
        depth: 23,
        sku: 'TV32-SAMS-XPT1U',
        supplier: supplier
      )
      product_model_2 = ProductModel.new(
        name: 'TV-32',
        weight: 4000,
        width: 32,
        height: 17,
        depth: 32,
        sku: 'TV32-SAMS-XPT1U',
        supplier: supplier
      )

      result = product_model_2.valid?

      expect(result).to eq(false)
    end
  end
end
