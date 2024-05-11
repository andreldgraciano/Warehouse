require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/id' do
    it 'com sucesso' do
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'SPO',
        city: 'São Paulo',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )

      get("/api/v1/warehouses/#{warehouse.id}")

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Aeroporto SP')
      expect(json_response['code']).to eq('SPO')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'e falha se não encontrar o galpão' do
      # Arrange

      get( '/api/v1/warehouses/999999999')

      expect(response.status).to eq(404)
    end
  end

  context 'GET /api/v1/warehouses' do
    it 'e retorna a coleçao de galpões' do
      Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'SPO',
        city: 'São Paulo',
        area: 80_000,
        address: 'Avenida do aeroporto ,123',
        zip: 3812783812,
        description: 'Galpão do aeroporto de SP'
      )
      Warehouse.create!(
        name: 'Rio',
        code: 'SDU',
        city: 'Rio de Janeiro',
        area: 50_000,
        address: 'Rua do galpão RJ, 123',
        zip: 321312312,
        description: 'Descricao galpao RJ'
      )

      get('/api/v1/warehouses')

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body) #como é uma coleçao, ele recebe um array
      expect(json_response.class).to eq(Array) #Nao é comum o teste, somente para exemplificar
      expect(json_response.length).to eq(2)
      expect(json_response[0]['name']).to eq('Aeroporto SP')
      expect(json_response[1]['name']).to eq('Rio')
    end

    it 'e retorna vazio se não houver galpões' do
      #Arrange

      get('/api/v1/warehouses')

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body) #como é uma coleçao, ele recebe um array
      expect(json_response).to eq([])
      expect(json_response.length).to eq(0)
    end

    it 'e falha se houver um erro do servidor' do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get('/api/v1/warehouses')

      expect(response).to have_http_status(500)
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'com sucesso' do
      warehouse_params = {
        warehouse: {
          name: 'Aeroporto SP',
          code: 'SPO',
          city: 'São Paulo',
          area: 80_000,
          address: 'Avenida do aeroporto ,123',
          zip: 3812783812,
          description: 'Galpão do aeroporto de SP'
        }
      }

      post '/api/v1/warehouses', params: warehouse_params

      # expect de status equivalentes.
      # expect(response.status).to eq(201)
      # expect(response).to have_http_status(:created)
      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Aeroporto SP')
      expect(json_response['code']).to eq('SPO')
      expect(json_response['city']).to eq('São Paulo')
      expect(json_response['area']).to eq(80_000)
      expect(json_response['address']).to eq('Avenida do aeroporto ,123')
      expect(json_response['zip']).to eq(3812783812)
      expect(json_response['description']).to eq('Galpão do aeroporto de SP')
    end

    it 'e falha se os parametros nao estao completos' do
      warehouse_params = {
        warehouse: {
          name: 'Aeroporto SP',
          code: 'SPO'
        }
      }

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(412)
      expect(response.body).not_to include('Nome não pode ficar em branco')
      expect(response.body).not_to include('Código não pode ficar em branco')
      expect(response.body).to include('Cidade não pode ficar em branco')
      expect(response.body).to include('Área não pode ficar em branco')
      expect(response.body).to include('Endereço não pode ficar em branco')
      expect(response.body).to include('CEP não pode ficar em branco')
      expect(response.body).to include('Descrição não pode ficar em branco')
    end

    it 'e falha se houver um erro do servidor' do
      warehouse_params = {
        warehouse: {
          name: 'Aeroporto SP',
          code: 'SPO',
          city: 'São Paulo',
          area: 80_000,
          address: 'Avenida do aeroporto ,123',
          zip: 3812783812,
          description: 'Galpão do aeroporto de SP'
        }
      }
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(500)
    end
  end
end
