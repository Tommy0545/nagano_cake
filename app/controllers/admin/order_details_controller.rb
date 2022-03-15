class Admin::OrderDetailsController < ApplicationController
    def update
      @order_detail = OrderDetail.find(params[:id])
      @order_detail.update(order_detail_params)
      if @order_detail.making_status == "in_production"
         @order=@order_detail.order
         @order.update(status: "in_production")
      elsif
        #@order_details = @order_detail.order.order_details
        @order_detail.order.order_details.count == @order_detail.order.order_details.where(making_status: "production_complete").count
        @order_detail.order.update(status: "preparing_delivery")
      end 
      
      redirect_to admin_order_path(@order_detail.order)
      
    end

  

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
