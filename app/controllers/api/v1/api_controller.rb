class Api::V1::ApiController < ActionController::API
  #Primeiro mais generico para depois mais especifico.
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500
  rescue_from ActiveRecord::RecordNotFound, with: :return_404
end
