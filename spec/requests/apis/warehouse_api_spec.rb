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
    end
  end
end
