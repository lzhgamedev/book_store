class Cart < ActiveRecord::Base
  belongs_to :book
  belongs_to :customer

  validates_presence_of :customer_id, :book_id, :quantity
  validates_numericality_of :quantity, allow_blank: true

  def self.list(customer_id)
    Cart.where(:customer_id => customer_id).order(:created_at)
  end

  def self.total(customer_id)
    self.list(customer_id).inject(0) {|total, cart|  total + cart.book.price * cart.quantity}
  end

  def self.checkout(customer_id)
    Cart.where(:customer_id => customer_id).delete_all
  end
  
end
