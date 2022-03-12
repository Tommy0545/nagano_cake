class Item < ApplicationRecord
    has_many :cart_items
    has_many :order_details
    belongs_to :genre
    
    validates :name, presence: true
    validates :introduction, presence: true
    validates :price, presence:true
    
    has_one_attached :image
    
    def with_tax_price
        (price * 1.1).floor
    end
end
