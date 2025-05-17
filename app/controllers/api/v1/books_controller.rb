class Api::V1::BooksController < ApplicationController
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      books = user.books
    elsif params[:category_id]
      category = Category.find(params[:category_id])
      books = category.books
    else
      books = Book.all
    end

    render json: books, include: [ :user, :category ]
  end

  def show
    book = Book.find(params[:id])
    render json: book, include: [ :user, :category]
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

  def book_params
    params.require(:book).permit(:title, :author, :user_id, :category_id)
  end
end
