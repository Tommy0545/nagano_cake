class Admin::OrdersController < ApplicationController
     before_action :authenticate_admin!
  def index
      @orders = Order.page(params[:page])
      
  end 
  
  def show
    @order = Order.find(params[:id])
   
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    if @order.status == "payment_confirmation"
      @order.order_details.each do |order_detail|
        order_detail.making_status = "production_pending"
        order_detail.save
      end
    end
    redirect_to admin_order_path(@order.id)
  end


  private

  def order_params
    params.require(:order).permit(:order_id,:status)
  end
end
