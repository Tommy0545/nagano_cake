class Public::ItemsController < ApplicationController
    def index
        @items=Item.all
        @items_count = @items.count
    end
    
    def show
        @item=Item.find(params[:id])
    end
end
