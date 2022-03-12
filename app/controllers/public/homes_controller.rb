class Public::HomesController < ApplicationController
  def top
     @items = Item.limit(4)
     
  end

  def about
  end
end
