class BooksController < ApplicationController
before_action :ensure_correct_user, only: [:update,:destroy,:edit]

def index
    @user=current_user
    @book=Book.new
    @books=Book.all
    
end
def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
if  @book.save
    redirect_to book_path(@book.id),notice: "You have updated user successfully"
   

else
    @books=Book.all
    @user=current_user
      render :index
end
end

def show
    @book =Book.find(params[:id])
    @user=@book.user
    # @userが投稿した人
    @book_new =Book.new
end
def edit
    @book = Book.find(params[:id])
end

def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
    redirect_to book_path(@book.id),notice: "You have updated user successfully"
   

    else
      render :edit
    end
 
 
end

def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
end

private

def ensure_correct_user
    @book= Book.find(params[:id])
    @user= @book.user
    if @user == current_user
        
    else
    redirect_to books_path    
    end
end    

def book_params
    params.require(:book).permit(:title, :body)
end



  
end
