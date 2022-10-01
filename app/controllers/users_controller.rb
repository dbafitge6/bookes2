class UsersController < ApplicationController
  
    def index
    @user=current_user
    @book=Book.new
    @books=Book.all
    @users=User.all
    
    end
def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    
    redirect_to books_path
end
def show
    @user =User.find(params[:id])
    @books=@user.books
    # @userが投稿した人
    @book_new =Book.new
    
end
def edit
    @user=User.find(params[:id])
    if @user == current_user
     render "edit"
    else 
    redirect_to user_path(current_user)
    
    end
end    
    
def update
    @user = User.find(params[:id])
    if @user.update(user_params)

# 3. データをデータベースに保存するためのsaveメソッド実行
      redirect_to user_path(@user.id),notice: "You have updated user successfully"
    else
      render "edit" 
    end
end
private



def user_params
    params.require(:user).permit(:name, :introduction,:profile_image)
end


end

