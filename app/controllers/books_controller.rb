class BooksController < ApplicationController
  def index
    if params[:category_id]
      @books = Book.where(category_id: params[:category_id]).order(:display_order)
    else
      @books = Book.order(:display_order).all
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
