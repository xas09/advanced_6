class BooksController < ApplicationController

  def new
    @books = Book.new
  end

  def create
    @books = Book.new(book_params)
    @book = Book.all
    @books.user_id = current_user.id
    @user = current_user
    if @books.save
    flash[:notice] = "successfully created"
    redirect_to book_path(@books)
    else
      render :index
    end
  end

  def index
    @books = Book.new
    @book = Book.all
    @user = current_user
  end

  def show
    @books = Book.new
    @book = Book.find(params[:id])
    @users = @book.user
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
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
