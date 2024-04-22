class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_orders

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_user_orders
    if user_signed_in?
      @user_orders = Order.where(user_id: current_user.id)
    end
  end
end
