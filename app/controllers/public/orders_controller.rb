class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

 def create
  @cart_items = current_customer.cart_items.all
  # ログインユーザーのカートアイテムをすべて取り出して cart_items に入れます
  @order = current_customer.orders.new(order_params)
  # 渡ってきた値を @order に入れます
  if @order.save
    # ここに至るまでの間にチェックは済ませていますが、念の為IF文で分岐させています
    @cart_items.each do |cart_item|
      # 取り出したカートアイテムの数繰り返します
      # order_item にも一緒にデータを保存する必要があるのでここで保存します
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.amount = cart_item.amount
      # 購入が完了したらカート情報は削除するのでこちらに保存します
      order_detail.price = cart_item.item.price
      # カート情報を削除するので item との紐付けが切れる前に保存します
      order_detail.save
     end
   current_customer.cart_items.destroy_all
    # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
  else
    @order = Order.new(order_params)
    render :new
  end
 end

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new
    @order.payment_method = params[:order][:payment_method]
    if params[:order][:address_number] == "1"
      @order.post_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_number] == "2"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
        render :new
    end
  end



  def thanx
  end


  def index
   @order_details = OrderDetail.all
   @orders = current_customer.orders.all
  end

  def show
   @order =  Order.find(params[:id])
  
  end


private
    def order_params
      params.require(:order).permit(:name, :address, :post_code, :postage, :total_payment, :payment_method)
    end
    def address_params
      params.require(:order).permit(:name, :address)
    end
end
