class Book < ActiveRecord::Base
  belongs_to :category

  def self.change_display_order(id, order)
    book = Book.find(id)
    book.display_order = order
    book.save!
  end
end
