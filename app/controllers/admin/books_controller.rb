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
  
  def reorder
    if request.xhr?
      order_infos = params[:order_infos]
      order_id = 1
      order_infos.each do |info|
        if info != ""
          last_index = info.length - 1
          id = info[4..last_index]
          Book.change_display_order(id,order_id)
          order_id += 1
        end
      end
      render :json => {info: "success"}
    end
  end
  # PATCH/PUT /admin/books/1
  def update
    if @book.update(book_params)
      if request.xhr?
        render :json =>{
          id: @book.id,
          isbn: @book.isbn,
          title: @book.title, 
          author: @book.author,
          price: @book.price,
          category_id: @book.category_id,
          description: @book.description
           }
      else
        redirect_to admin_book_path(@book), notice: '更新しました'
      end
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/books/1
  def destroy
    delete_id = @book.id
    @book.destroy
    if request.xhr?
      render :json =>{ delete_id: delete_id }
    else
      redirect_to admin_books_url, notice: '削除しました'
    end
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
