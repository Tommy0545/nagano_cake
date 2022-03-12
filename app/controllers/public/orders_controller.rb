class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  # 購入を確定します
def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items
      if @cart_items.each do |cart_item|
        order_details = OrderDetail.new
        order_details.item_id = cart_item.item_id
        order_details.order_id = @order.id
        order_details.price = cart_item.item.price
        order_details.amount = cart_item.amount
        order_details.save
       end
      end
    @cart_items.destroy_all
    render :thanx
end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.post_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      address = Address.find(params[:order][:address_id])
      @order.post_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    elsif params[:order][:address_option] == "2"
      @order = current_customer.orders.new(order_params)
    end
    @order.postage = 800
  end



  def thanx
  end


  def index
    @orders = current_customer.orders.all
    @order_details = OrderDetail.all
   
  end

  def show
   @order = Order.find(params[:id])
  
  end


private
    def order_params
      params.require(:order).permit(:name, :address, :post_code, :postage, :total_payment, :payment_method)
    end
    def address_params
      params.require(:order).permit(:name, :address)
    end
end
