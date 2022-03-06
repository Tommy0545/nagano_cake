class Public::CartItemsController < ApplicationController
def create
   @cart_item = CartItem.new(cart_item_params)
   @items = Item.all
   @item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
  
    redirect_to public_cart_items_path
end

def index
  @customer = current_customer
  @cart_item = current_customer.cart_items.all
  
end

def update
   @cart_item = CartItem.find(params[:id])
   @cart_item.update(cart_item_params)
   redirect_to request.referer

end

def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
end

def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_items_path
end




private
def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount, :cart_item)
end
  
   

end
