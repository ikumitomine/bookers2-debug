class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @book_n = Book.new
    @user = @book.user
  end

  def index
    @books = Book.all
    @book_n = Book.new
  end

  def create
    @book_n = Book.new(book_params)
    @book_n.user_id = current_user.id
    if @book_n.save
      redirect_to book_path(@book_n), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book_n = Book.find(params[:id])
  end


  def update
    @book_n = Book.find(params[:id])
    if @book_n.update(book_params)
      redirect_to book_path(@book_n), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  private
  def correct_user
    book = Book.find(params[:id])
      if current_user.id != book.user_id
      redirect_to books_path
      end
  end

end
