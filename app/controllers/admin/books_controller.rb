class Admin::BooksController < ApplicationController
  layout 'admin'

  before_action :authenticate_manager!
  before_action :set_admin_book, only: [:show, :edit, :update, :destroy]

  # GET /admin/books
  def index
    if params[:category_id]
      @books = Book.where(category_id: params[:category_id]).order(:display_order)
    else
      @books = Category.first.books.order(:display_order)
    end
    render layout: 'admin'
  end

  # GET /admin/books/1
  def show
  end

  # GET /admin/books/new
  def new
    @book = Book.new
  end

  # GET /admin/books/1/edit
  def edit
  end

  # POST /admin/books
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to admin_book_path(@book), notice: '作成しました'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/books/1
  def update
    if @book.update(book_params)
      redirect_to admin_book_path(@book), notice: '更新しました'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/books/1
  def destroy
    @book.destroy
    redirect_to admin_books_url, notice: '削除しました'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :title, :author, :price, :category_id, :icon_path, :picture_path, :description, :display_order)
    end
end
