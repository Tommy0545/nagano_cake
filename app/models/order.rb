class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  belongs_to :customer
  has_many :order_details

      def with_tax_price
          (price * 1.1).floor
      end
      def subtotal
         item.with_tax_price * amount
      end
end
