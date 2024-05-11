class Api::V1::WarehousesController < ActionController::API
  def index
    warehouses = Warehouse.all
    render status: 200, json: warehouses
  end

  def show
    begin
      warehouse = Warehouse.find(params[:id])
      render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404, json: { }
    end

    # Usando find_by
    # warehouse = Warehouse.find_by(id: params[:id])
    # if warehouse.nil?
    #   return render status: 404, json: { }
    # end
    # render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
  end
end
