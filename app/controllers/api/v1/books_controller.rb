class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: [ :show, :update, :destroy ]
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @books = @user.books
    elsif params[:category_id]
      @category = Category.find(params[:category_id])
      @books = @category.books
    else
      @books = Book.all
    end
    render json: @books, include: [ :user, :category ]
  end

  def show
    render json: @book, include: [ :user, :category ]
  end

  def update
    if @book.update!(book_params)
      render json: @book
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def destroy
    if @book.destroy
      head :no_content
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: book, status: :created
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def set_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Book not found" }
  end

  def book_params
    params.require(:book).permit(:title, :author, :user_id, :category_id)
  end
end
