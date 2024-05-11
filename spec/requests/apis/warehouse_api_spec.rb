require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/1' do
    it 'success' do
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

    it 'falha se não encontrar o galpão' do
      #

      get( '/api/v1/warehouses/999999999')

      expect(response.status).to eq(404)
    end
  end

  context 'GET /api/v1/warehouses' do
    it 'e retorne a coleçao de galpões' do
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

    it 'retorna vazio se não houver galpões' do
      #Arrange

      get('/api/v1/warehouses')

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body) #como é uma coleçao, ele recebe um array
      expect(json_response).to eq([])
      expect(json_response.length).to eq(0)
    end
  end
end
