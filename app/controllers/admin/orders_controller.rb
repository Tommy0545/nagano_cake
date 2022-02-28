class Admin::OrdersController < ApplicationController
     before_action :authenticate_admin!
  
  
  def index
   if params[:customer_id]
     @orders = Order.where(customer_id: params[:customer_id])
   else
     @orders = Order.all.order(created_at: :desc)
   end
  end

  def show
    @order = Order.find(params[:id])
    @order.postage = 800
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
