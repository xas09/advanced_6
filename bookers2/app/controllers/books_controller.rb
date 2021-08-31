class BooksController < ApplicationController
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def create
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
    flash[:notice] = "successfully created"
    redirect_to book_path(@book)
    else
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @users = @book.user
    @book_comment = BookComment.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
   @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "successfully updated"
    redirect_to book_path(@book)
    else
      render :edit
    end
  end

  private

  def ensure_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
    redirect_to books_path
    end
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
