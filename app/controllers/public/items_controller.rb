class Public::ItemsController < ApplicationController
    
    def index
        @items = Item.page(params[:page])
        @items_count = @items.count
    end
    
    def show
        @item=Item.find(params[:id])
        @cart_items = CartItem.new
    end
    
    
end
