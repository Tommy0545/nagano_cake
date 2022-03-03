class Public::ItemsController < ApplicationController
    def index
        @items=Item.all
        @items_count = @items.count
        @items_page = Item.page(params[:page])
    end
    
    def show
        @item=Item.find(params[:id])
    end
end
